class Course < ActiveRecord::Base
  has_many :course_subjects, dependent: :destroy
  has_many :user_courses, dependent: :destroy
  has_many :subjects, through: :course_subjects
  has_many :users, through: :user_courses

  validates :title, presence: true
  validates :description, presence: true

  accepts_nested_attributes_for :subjects
end
