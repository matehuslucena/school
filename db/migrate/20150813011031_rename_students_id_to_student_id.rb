class RenameStudentsIdToStudentId < ActiveRecord::Migration
  def change
    rename_column :classrooms, :students_id, :student_id
  end
end
