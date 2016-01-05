class User < ActiveRecord::Base
  enum role: [:normal, :admin]

  has_many :exams, dependent: :destroy
  has_many :questions, dependent: :destroy

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true, length: {maximum: 50}
  validates :chatwork_id, presence: true,
    length: {maximum: 50}, uniqueness: true
  validates :email, length: {maximum: 255}
  validates :role, presence: true
end
