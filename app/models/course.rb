class Course < ActiveRecord::Base
  enum status: [:incoming, :started, :finished]

  has_one :owner, class_name: User.name
  has_many :course_subjects, dependent: :destroy
  has_many :user_courses, dependent: :destroy
  has_many :subjects, through: :course_subjects
  has_many :users, through: :user_courses

  validates :title, presence: true
  validates :description, presence: true

  accepts_nested_attributes_for :subjects

  def add_owner owner_id 
    Course.transaction do
      begin 
        self.update_attribute :owner_id, owner_id 
        self.update_attribute :user_ids, owner_id
      rescue
        raise ActiveRecord::Rollback
      end
    end
  end
end
