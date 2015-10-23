class User < ActiveRecord::Base
  extend EnumerateIt
  TEMP_EMAIL_PREFIX = 'change@me'
  TEMP_EMAIL_REGEX = /\Achange@me/
  before_save :set_active_status
  after_save :assign_role

  devise :database_authenticatable, :registerable, :confirmable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  has_one :blogger, dependent: :destroy
  has_and_belongs_to_many :roles

  validates_format_of :email, :without => TEMP_EMAIL_REGEX, on: :update

  has_enumeration_for :status, with: ::CommonStatus, required: true, create_scopes: true

  def self.find_for_oauth(auth, signed_in_resource = nil)
    identity = Identity.find_for_oauth(auth)
    user = signed_in_resource ? signed_in_resource : identity.user

    if user.nil?
      email_is_verified = auth.info.email && auth.info.verified
      email = auth.info.email if email_is_verified
      user = User.where(:email => email).first if email

      if user.nil?
        user = User.new(
          name: auth.extra.raw_info.name,
          email: email ? email : "#{TEMP_EMAIL_PREFIX}-#{auth.uid}-#{auth.provider}.com",
        )
        user.status = CommonStatus::ACTIVE if !user.status
        user.image = auth.info.image if user.image.blank?
        user.password = Devise.friendly_token[0,20] if !user.password
        user.skip_confirmation!
        user.save!
      end
    end

    if identity.user != user
      identity.user = user
      identity.save!
    end
    user
  end

  def email_verified?
    self.email && self.email !~ TEMP_EMAIL_REGEX
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
        user.image = data["info"]["image"] if user.image.blank?
      end
    end
  end

  def self.provides_role_check_for(role_name)
    class_eval %Q{
      def #{role_name}?
        self.roles.exists?(Role.find_by(kind:RoleKind::#{role_name.to_s.upcase!}))
      end
    }
  end

  # roles check
  [:regular, :admin, :pastor, :blogger, :accountant, :teacher, :director].each do |role_name|
    self.provides_role_check_for role_name
  end

  private
  def assign_role
    regular_role = Role.find_or_create_by(
      kind:RoleKind::REGULAR,
      name:"Regular",
      description: "Papel básico")
    self.roles.push regular_role unless self.roles.exists?(regular_role)
  end

  def set_active_status
    self.status = CommonStatus::ACTIVE
  end
end
