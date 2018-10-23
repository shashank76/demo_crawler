require 'will_paginate/array'
class NewsController < ApplicationController
	before_action :require_user,only: [:index]
	before_action :update_info,only: [:index]

	def index 
		@news = News.not_deleted(current_user).paginate(:page => params[:page], :per_page => 10)
		fresh_when etag: @news
	end

	def update_viewer
		@user_news = UserNews.find_or_create_by(user_id: params[:user_id],news_id: params[:news_id])
		@count = UserNews.where(user_id: params[:user_id],news_id: params[:news_id]).count
		if @user_news.present?
			render :json => {:status  => true, :count => @count}
		else
			render :json => {:status  => false}
		end
	end

	def destroy
		@deleted_news = DeletedNews.find_or_create_by(news_id: params[:news_id],user_id: params[:user_id])
		if @deleted_news.present?
			render :json => {:status  => true}
		else
			render :json => {:status  => false}
		end
	end
end
