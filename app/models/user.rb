class User < ActiveRecord::Base
  has_many :user_skills
  has_many :user_projects
  has_many :projects, through: :user_projects
  has_many :skills, through: :user_skills
  belongs_to :team
  belongs_to :position
  before_save { self.email = email.downcase }
  has_attached_file :avatar,
    default_url: "/assets/default_icon.png",
    path: ":attachment/:id/:style.:extension",
    storage: :s3,
    url: ":s3_alias_url",
    s3_host_alias: "#{your_bucket}.s3.amazonaws.com", # your s3_domain
    s3_protocol: "https",
    s3_credentials: {
      bucket: Rails.configuration.aws[:access_key_id],  # your_bucket
      access_key_id: Rails.configuration.aws[:secret_access_key],
      secret_access_key: Rails.configuration.aws[:bucket]
    },
    styles: {
      large: "1024x1024>", # size and style's name
      normal: "600x600>",
      thumb: "120x120#"
    },
    convert_options: {all: "-background white -flatten +matte"}

  attr_accessor :not_validate_password

  before_save { self.email = email.downcase }
  validates :name,  presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }, uniqueness: { case_sensitive: false }
  validates :password,  presence: true, length: { minimum: 6 }, unless: :not_validate_password
  has_secure_password

  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/ # validate file's type only is image

  accepts_nested_attributes_for :user_skills, :reject_if => proc { |a| a[:skill_id].blank? }
 
 def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.digest(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  private

    def create_remember_token
      self.remember_token = User.digest(User.new_remember_token)
    end
end
