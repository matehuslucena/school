class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]

  # GET /students
  # GET /students.json
  def index
    @students = Student.all
  end

  # GET /students/1
  # GET /students/1.json
  def show
  end

  # GET /students/new
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit
  end

  # POST /students
  # POST /students.json
  def create
    @student = Student.new(student_params)

    respond_to do |format|
      if @student.save
        format.html { redirect_to @student, notice: 'Student was successfully created.' }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to @student, notice: 'Student was successfully updated.' }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student.destroy
    respond_to do |format|
      format.html { redirect_to students_url, notice: 'Student was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def courses
    @courses = Course.all
    @student = Student.find(params[:id])
  end

  def choose_courses
    course_ids = params[:student][:course_ids]
    student_id = params[:id]
    if student_has_not_classrooms(student_id)
      flash[:notice] = save_new_student_courses(student_id, course_ids)
    else
      flash[:notice] = update_student_courses(student_id, course_ids)
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_student
    @student = Student.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def student_params
    params.require(:student).permit(:name, :register_number, :status)
  end

  def student_has_not_classrooms(student_id)
    classroom = Classroom.where(student_id: student_id)
    if classroom.empty?
      true
    else
      false
    end
  end

  def save_new_student_courses(student_id, course_ids)
    course_ids.each do |course_id|
      unless course_id.empty?
        classroom = Classroom.new
        classroom.student_id = student_id
        classroom.course_id = course_id
        classroom.entry_at = Time.new
        if classroom.save
          'Courses are successfully chosen.'
        else
          'Courses are not save.'
        end
      end
    end
  end

  def update_student_courses(student_id, course_ids)
    Classroom.destroy_all(student_id: student_id)
    save_new_student_courses(student_id, course_ids)
  end
end
