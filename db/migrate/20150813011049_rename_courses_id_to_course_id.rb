class RenameCoursesIdToCourseId < ActiveRecord::Migration
  def change
    rename_column :classrooms, :courses_id, :course_id
  end
end
