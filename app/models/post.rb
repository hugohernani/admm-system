class Post < ActiveRecord::Base
  extend FriendlyId
  extend EnumerateIt
  friendly_id :title, use: [:slugged, :finders]

  belongs_to :blogger
  has_many :comments, dependent: :destroy

  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  validates :body, presence: true
  validates :blogger, presence: true

  has_enumeration_for :status, with: ::CommonStatus, required: true, create_scopes: true

  def should_generate_new_friendly_id?
    new_record?
  end

  scope :by_user, ->(user_id) { blogger.user_id == user_id }  
end
