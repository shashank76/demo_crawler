class News < ApplicationRecord

	has_many :user_news,dependent: :destroy
	has_many :viewers, through: :user_news, source: :user
	has_many :deleted_news, dependent: :destroy

	after_create :expire_cache
	after_update :expire_cache
	before_destroy :expire_cache

	def self.not_deleted(user)
		News.all.order("created_at desc") - user.deleted_news.map(&:news)
	end

	def expire_cache
		ActionController::Base.new.expire_fragment(@news)
	end
end
