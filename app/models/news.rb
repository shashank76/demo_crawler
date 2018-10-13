class News < ApplicationRecord

	has_many :user_news,dependent: :destroy
	has_many :viewers, through: :user_news, source: :user
	has_many :deleted_news, dependent: :destroy

	def self.not_deleted(user)
		News.all - user.deleted_news.map(&:news)
	end
end
