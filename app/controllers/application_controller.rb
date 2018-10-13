class ApplicationController < ActionController::Base
	protect_from_forgery with: :null_session
	helper_method :current_user

   def current_user
  	 current_user ||= User.find_by(id: cookies.signed[:user_id]) if cookies.signed[:user_id]
   end

    def require_user
  		redirect_to new_session_path unless current_user.present?		
    end

    def update_info
    	require "nokogiri" 
		require "open-uri"
		require 'openssl'
    	doc = Nokogiri::HTML(open('https://news.ycombinator.com/news', :ssl_verify_mode => OpenSSL::SSL::VERIFY_NONE))
		@list = doc.css('table > tr > td > table > tr')
		a=1
		@values = []
		@list.each_with_index do |data,index|
			url = @list[a].children[4].children[0].attributes.values[0].value
			title = @list[a].children[4].children[0].text
			hacker_url = @list[a].children[4].children[1].present? ? @list[a].children[4].children[1].children[1].children[0].text : ''
			posted_at = @list[a+1].children[1].children[5].present? ? @list[a+1].children[1].children[5].text : ''
			upvote = @list[a+1].children[1].present? ? @list[a+1].children[1].children[1].text : ''
			comments_count = @list[a+1].children[1].children[11].present? ? @list[a+1].children[1].children[11].text : '' 
			@news = News.find_or_create_by(url: url)
			@news.update_attributes(title: title, hacker_url: hacker_url,posted_on: posted_at, upvotes: upvote, comments: comments_count)
			@values << url
			a = a + 3
			unless @list[a].children.present?
				break
			end
		end
    end
end
