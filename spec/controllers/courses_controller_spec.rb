require 'rails_helper'

describe CoursesController do

  describe 'GET #index' do
    it 'populate an array of courses' do
      course = create(:course)
      get :index
      expect(assigns(:courses)).to eq([course])
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe 'GET #show' do
    it 'assigns the requested post to @course' do
      course = create(:course)
      get :show, id: course
      expect(assigns(:course)).to eq(course)
    end

    it 'renders the #show view' do
      course = create(:course)
      get :show, id: course
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
      it 'creates a new course' do
        expect {
          post :create, course: attributes_for(:course)
        }.to change(Course, :count).by(1)
      end

      it 'redirects to the new course' do
        post :create, course: attributes_for(:course)
        expect(response).to redirect_to Course.last
      end
    end

    context 'with invalid attributes' do
      it 'does not save the new course' do
        expect {
          post :create, course: attributes_for(:invalid_course)
        }.to_not change(Course, :count)
      end

      it 're-renders the new method' do
        post :create, course: attributes_for(:invalid_course)
        expect(response).to render_template :new
      end
    end
  end

  describe 'PUT #update' do

    before :each do
      @course = create(:course, name: 'new course', description: 'description')
    end

    context 'valid attributes' do
      it 'located the requested @student' do
        put :update, id: @course, course: attributes_for(:course)
        expect(assigns(:course)).to eq(@course)
      end

      it 'changes @course attributes' do
        put :update, id: @course, course: attributes_for(:course, name: 'New course', description: 'description')
        @course.reload
        expect(@course.name).to eq('New course')
        expect(@course.description).to eq('description')
      end

      it 'redirects to the updated course' do
        put :update, id: @course, course: attributes_for(:course)
        expect(response).to redirect_to course_path(@course)
      end
    end

    context 'invalid attributes' do
      it 'locates the requested @course' do
        put :update, id: @course, course: attributes_for(:invalid_course)
        expect(assigns(:course)).to eq(@course)
      end

      it 'does not change @course attributes' do
        put :update, id: @course, course: attributes_for(:course, name: 'New name', description: nil)
        @course.reload
        expect(@course.name).not_to eq('New name')
        expect(@course.description).to eq('description')
      end

      it 're-renders the edit method' do
        put :update, id: @course, course: attributes_for(:invalid_course)
        expect(response).to render_template :edit
      end
    end
  end

  describe 'DELETE #destroy' do
    before :each do
      @course = create(:course)
    end

    it 'deletes the post' do
      expect {
        delete :destroy, id: @course
      }.to change(Course, :count).by(-1)
    end

    it 'redirects to posts#index' do
      delete :destroy, id: @course
      expect(response).to redirect_to courses_url
    end
  end
end