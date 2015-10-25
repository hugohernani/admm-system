class Theme < ActiveRecord::Base
  extend EnumerateIt, FriendlyId
  friendly_id :title, use: [:slugged, :finders]

  belongs_to :blogger
  has_many :posts, dependent: :destroy

  delegate :user, to: :blogger

  validates :title, presence: true, uniqueness: true
  validates :description, presence: true

  has_enumeration_for :status, with: CommonStatus, required: true, create_scopes: true

  def should_generate_new_friendly_id?
    new_record?
  end

end
