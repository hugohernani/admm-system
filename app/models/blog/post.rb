module Blog
  class Post < ActiveRecord::Base
    extend FriendlyId
    extend EnumerateIt
    friendly_id :title, use: [:slugged, :finders]

    belongs_to :user
    has_many :blog_comments, dependent: :destroy, class_name: "Blog::Comment"

    validates :title, presence: true, uniqueness: true
    validates :description, presence: true
    validates :body, presence: true
    validates :user, presence: true

    has_enumeration_for :status, with: ::CommonStatus, required: true, create_scopes: true

    def should_generate_new_friendly_id?
      new_record?
    end
  end
end
