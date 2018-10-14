class UserNews < ApplicationRecord
  belongs_to :user
  belongs_to :news

  	after_create :expire_cache
	after_update :expire_cache
	before_destroy :expire_cache

	def expire_cache
		ActionController::Base.new.expire_fragment(@news)
	end
end
