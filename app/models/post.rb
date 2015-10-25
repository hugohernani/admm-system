class Post < ActiveRecord::Base
  extend FriendlyId, EnumerateIt
  include PgSearch
  friendly_id :title, use: [:slugged, :finders]

  belongs_to :theme
  delegate :blogger, to: :theme
  delegate :user, to: :blogger
  has_many :comments, dependent: :destroy

  validates :title, presence: true, uniqueness: true
  validates :description, presence: true
  validates :body, presence: true
  validates :blogger, presence: true

  has_enumeration_for :status, with: ::CommonStatus, required: true, create_scopes: true

  def should_generate_new_friendly_id?
    new_record?
  end

  pg_search_scope :full_text_search, against: [:title, :description],
                                         using: { tsearch: {
                                           any_word: true,
                                           prefix: true,
                                           normalization: 10 }
                                         }

  def self.search(query)
    query.present? && !query.empty? ? full_text_search(query) : all
  end

  scope :by_blogger, ->(id) { where("blogger_id = ?", id) }
end
