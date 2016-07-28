class User < ActiveRecord::Base
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  has_many :active_relationships, class_name: Relationship.name,
    foreign_key: "follower_id", dependent: :destroy
  has_many :passive_relationships, class_name: Relationship.name,
    foreign_key: "followed_id", dependent: :destroy
  has_many :following, through: :active_relationships, source: :followed
  has_many :followers, through: :passive_relationships, source: :follower
  has_many :user_subjects, dependent: :destroy
  has_many :user_courses, dependent: :destroy
  has_many :user_tasks, dependent: :destroy
  has_many :subjects, through: :user_subjects
  has_many :courses, through: :user_courses
  has_many :tasks, through: :user_tasks

  has_secure_password

  validates :name,  presence: true, length: {maximum: 50}
  validates :email, presence: true, length: {maximum: 255},
    format: {with: VALID_EMAIL_REGEX},
    uniqueness: {case_sensitive: false}
  validates :password, presence: true, length: {minimum: 1}

  before_save {self.email = email.downcase}

  enum role: [:trainee, :supervisor, :admin]
end
