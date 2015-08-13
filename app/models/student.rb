class Student < ActiveRecord::Base
  validates_presence_of :name, :register_number

  has_many :classrooms
  has_many :courses, through: :classrooms

  def self.student_has_not_classrooms(student_id)
    classroom = Classroom.where(student_id: student_id)
    if classroom.empty?
      true
    else
      false
    end
  end

  def self.save_new_student_courses(student_id, course_ids)
    message = ''
    course_ids.each do |course_id|
      unless course_id.empty?
        classroom = Classroom.new
        classroom.student_id = student_id
        classroom.course_id = course_id
        classroom.entry_at = Time.new
        if classroom.save
          message = 'Courses are successfully chosen.'
        else
          message = 'Courses are not save.'
        end
      end
    end
    message
  end

  def self.update_student_courses(student_id, course_ids)
    Classroom.destroy_all(student_id: student_id)
    save_new_student_courses(student_id, course_ids)
  end
end
