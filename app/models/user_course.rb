class UserCourse < ActiveRecord::Base
  belongs_to :user
  belongs_to :course
  
  has_many :user_subjects, dependent: :destroy

  enum status: [:incoming, :started, :finished]
end