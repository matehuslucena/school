require 'rails_helper'

describe StudentsController do

  describe 'GET #index' do
    it 'populate an array of students' do
      student = create(:student)
      get :index
      expect(assigns(:students)).to eq([student])
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    it 'assigns the requested post to @student' do
      student = create(:student)
      get :show, id: student
      expect(assigns(:student)).to eq(student)
    end

    it 'renders the #show view' do
      student = create(:student)
      get :show, id: student
      expect(response).to render_template :show
    end
  end

  describe 'GET #new' do
    it 'renders the #new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      it 'creates a new student' do
        expect {
          post :create, student: attributes_for(:student)
        }.to change(Student, :count).by(1)
      end

      it 'redirects to the new student' do
        post :create, student: attributes_for(:student)
        expect(response).to redirect_to Student.last
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new student' do
        expect {
          post :create, student: attributes_for(:invalid_student)
        }.to_not change(Student, :count)
      end

      it 're-renders the new method' do
        post :create, student: attributes_for(:invalid_student)
        expect(response).to render_template :new
      end
    end
  end

  describe 'PUT #update' do

    before :each do
      @student = create(:student, name: 'new name', register_number: '123')
    end

    context 'valid attributes' do
      it 'located the requested @student' do
        put :update, id: @student, student: attributes_for(:student)
        expect(assigns(:student)).to eq(@student)
      end

      it 'changes @student attributes' do
        put :update, id: @student, student: attributes_for(:student, name: 'New student', register_number: '321')
        @student.reload
        expect(@student.name).to eq('New student')
        expect(@student.register_number).to eq('321')
      end

      it 'redirects to the updated student' do
        put :update, id: @student, student: attributes_for(:student)
        expect(response).to redirect_to student_path(@student)
      end
    end

    context 'invalid attributes' do
      it 'locates the requested @student' do
        put :update, id: @student, student: attributes_for(:invalid_student)
        expect(assigns(:student)).to eq(@student)
      end

      it 'does not change @student attributes' do
        put :update, id: @student, student: attributes_for(:student, name: 'New name', register_number: nil)
        @student.reload
        expect(@student.name).not_to eq('New name')
        expect(@student.register_number).to eq('123')
      end

      it 're-renders the edit method' do
        put :update, id: @student, student: attributes_for(:invalid_student)
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @student = create(:student)
    end

    it 'deletes the post' do
      expect{
        delete :destroy, id: @student
      }.to change(Student,:count).by(-1)
    end

    it 'redirects to posts#index' do
      delete :destroy, id: @student
      expect(response).to redirect_to students_url
    end
  end
end