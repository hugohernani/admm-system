class Blogger < ActiveRecord::Base
  extend FriendlyId
  friendly_id :theme, use: [:slugged, :finders]

  belongs_to :user

  def should_generate_new_friendly_id?
    new_record?
  end
end
