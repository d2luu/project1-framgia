class UserCourse < ActiveRecord::Base
  belongs_to :user
  belongs_to :course
  
  has_many :user_subjects, dependent: :destroy

  scope :supervisors, -> {joins(:user).where users: {role: "1"}}
  scope :trainees, -> {joins(:user).where users: {role: "0"}}
end
