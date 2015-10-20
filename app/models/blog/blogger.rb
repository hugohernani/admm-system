module Blog
  class Blogger < ActiveRecord::Base
    extend FriendlyId
    extend EnumerateIt
    friendly_id :slugged_name, use: [:slugged, :finders]

    belongs_to :user

    validates :theme, presence: true, uniqueness: true
    validates :description, presence: true

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
end
