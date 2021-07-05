class Book < ApplicationRecord
	belongs_to :user
	has_many :favorites,dependent: :destroy
	has_many :post_comments,dependent: :destroy

	# 引数で渡されたユーザーIDが、Favoritesテーブル内に存在するか調べる
	def favorited_by?(user)
		favorites.where(user_id:user.id).exists?
	end


	validates :title, presence: true
	validates :body, presence: true, length: {maximum: 200}
end
