class Blogger < ActiveRecord::Base
  extend EnumerateIt

  belongs_to :user
  has_many :themes, dependent: :destroy

  delegate :name, to: :user
  delegate :posts, to: :themes

  validates :user, presence: true

  has_enumeration_for :status, with: CommonStatus, required: true, create_scopes: true
end
