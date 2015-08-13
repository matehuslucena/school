class Course < ActiveRecord::Base
  validates_presence_of :name, :description

  has_many :classrooms
  has_many :students, through: :classrooms
end
