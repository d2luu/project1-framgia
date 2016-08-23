class CourseSubject < ActiveRecord::Base
  enum status: [:incoming, :started, :finished]

  belongs_to :course
  belongs_to :subject

  def create_user_subject
    UserCourse.user_courses(self.course_id).each do |user_course|
      UserSubject.create user_id: user_course.user_id,
        subject_id: self.subject_id,
        user_course_id: user_course.id,
        status: :started
    end
  end
end
