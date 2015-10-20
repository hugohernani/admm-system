class User < ActiveRecord::Base
  extend EnumerateIt
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  has_many :bloggers

  has_enumeration_for :status, with: ::CommonStatus, required: true, create_scopes: true
end
