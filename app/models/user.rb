class User < ActiveRecord::Base
  extend FriendlyId
  enum role: [:normal, :admin]
  friendly_id :name, use: :slugged
  devise :omniauthable, omniauth_providers: [:facebook]

  has_many :exams, dependent: :destroy
  has_many :questions, dependent: :destroy
  has_many :activities, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true, length: {maximum: 50}
  validates :chatwork_id, presence: true,
    length: {maximum: 50}, uniqueness: true
  validates :email, length: {maximum: 255}
  validates :role, presence: true

  def self.from_omniauth auth
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.email = auth.provider + "." + auth.uid + "@fts48.com"
      user.password = Devise.friendly_token[0,20]
      user.password_confirmation = user.password
      user.chatwork_id = auth.provider + auth.uid
      user.name = auth.info.name
      user.save!
    end
  end

end
