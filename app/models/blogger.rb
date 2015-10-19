class Blogger < ActiveRecord::Base
  extend FriendlyId
  friendly_id :slugged_name, use: [:slugged, :finders]

  belongs_to :user

  def should_generate_new_friendly_id?
    new_record?
  end

  def slugged_name
    [
      user.name,
      [user.name, :theme]
    ]
  end
end
