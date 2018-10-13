module NewsHelper

	def viewers_count(news)
		news.viewers.count
	end
end
