class Subject < ActiveRecord::Base
  has_many :tasks, dependent: :destroy
  has_many :course_subjects, dependent: :destroy
  has_many :user_subjects, dependent: :destroy
  has_many :users, through: :user_subjects
  has_many :courses, through: :course_subjects

  validates :title, presence: true
  validates :description, presence: true

  accepts_nested_attributes_for :tasks, allow_destroy: true,
    reject_if: lambda {|a| a[:title].blank? || a[:description].blank?}
end
