class Blogger < ActiveRecord::Base
  extend FriendlyId, EnumerateIt
  acts_as_votable
  friendly_id :slugged_name, use: [:slugged, :finders]

  belongs_to :user
  has_many :posts, dependent: :destroy

  validates :theme, presence: true, uniqueness: true
  validates :description, presence: true
  validates :user, presence: true

  has_enumeration_for :status, with: ::CommonStatus, required: true, create_scopes: true

  def should_generate_new_friendly_id?
    new_record?
  end

  def slugged_name
    unless user.nil?
      [
        user.name,
        [user.name, :theme]
      ]
    else
      [
        :theme
      ]
    end
  end
end
