require 'rails_helper'

RSpec.describe TasksController, type: :controller do
  describe 'GET #index' do
    it 'returns a success response' do
      Task.create!(
        title: 'Task 1',
        description: 'Description 1',
        expires_at: Time.now,
        status: :pending
      )

      get :index
      expect(response).to be_successful
      expect(response.body).to eq(Task.all.to_json)
    end

    it 'returns an empty payload' do
      get :index
      expect(response.body).to eq('[]')
    end
  end

  describe 'GET #show' do
    it 'returns a success response' do
      task = Task.create!(
        title: 'Task 1',
        description: 'Description 1',
        expires_at: Time.now,
        status: :pending
      )

      get :show, params: { id: task.id }
      expect(response).to be_successful
      expect(response.body).to eq(task.to_json)
    end

    it 'returns a not found response' do
      get :show, params: { id: 0 }
      expect(response).to have_http_status(:not_found)
    end
  end

  describe 'POST #create' do
    it 'returns a success response' do
      task = {
        title: 'Task 1',
        description: 'Description 1',
        expires_at: Time.now,
        status: :pending
      }

      post :create, params: { task: task }
      expect(response).to have_http_status(:created)
      expect(response.body).to eq(Task.last.to_json)
    end

    it 'returns an unprocessable entity response' do
      task = {
        title: 'T',
        description: 'D',
        expires_at: Time.now,
        status: :pending
      }

      post :create, params: { task: task }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'PUT #update' do
    it 'returns a success response' do
      task = Task.create!(
        title: 'Task 1',
        description: 'Description 1',
        expires_at: Time.now,
        status: :pending
      )

      task.title = 'Task 2'

      put :update, params: { id: task.id, task: task.attributes }
      expect(response).to be_successful
    end

    it 'returns an unprocessable entity response' do
      task = Task.create!(
        title: 'Task 1',
        description: 'Description 1',
        expires_at: Time.now,
        status: :pending
      )

      task.title = 'T'

      put :update, params: { id: task.id, task: task.attributes }
      expect(response).to have_http_status(:unprocessable_entity)
    end
  end

  describe 'DELETE #destroy' do
    it 'returns a success response' do
      task = Task.create!(
        title: 'Task 1',
        description: 'Description 1',
        expires_at: Time.now,
        status: :pending
      )

      delete :destroy, params: { id: task.id }
      expect(response).to be_successful
    end

    it 'returns a not found response' do
      delete :destroy, params: { id: 0 }
      expect(response).to have_http_status(:not_found)
    end
  end
end
