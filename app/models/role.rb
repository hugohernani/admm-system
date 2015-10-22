class Role < ActiveRecord::Base
  extend EnumerateIt
  has_and_belongs_to_many :users

  validates :name, presence: true

  has_enumeration_for :kind, with: RoleKind, required: true, create_scopes: true
end
