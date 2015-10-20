module Blog
  class Comment < ActiveRecord::Base
    belongs_to :post, class_name: Blog::Post, foreign_key: :blog_post_id
    belongs_to :user, class_name: ::User

    validates :content, presence: true
    validates :user, presence: true
    validates :post, presence: true
  end
end
