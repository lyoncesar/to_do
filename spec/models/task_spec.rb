require 'rails_helper'

RSpec.describe Task, type: :model do
  context 'validations' do
    it { should validate_presence_of(:title) }
    it { should validate_length_of(:description) }
    it { should define_enum_for(:status).with_values([ :pending, :completed ]) }
  end

  context '#persist' do
    it 'should persist a valid task' do
      task = Task.new(
        title: 'Task 1',
        description: 'Description 1',
        expires_at: Time.now,
        status: :pending
      )

      expect(task.save).to eq true
    end

    it 'should not persist an invalid task' do
      task = Task.new(
        title: 'T',
        description: 'Description 1',
        expires_at: Time.now,
        status: :pending
      )

      expect(task.save).to eq false
    end
  end

  context '#update' do
    it 'should update a task' do
      task = Task.create!(
        title: 'Task 1',
        description: 'Description 1',
        expires_at: Time.now,
        status: :pending
      )

      expect(task.update(title: 'Task 2')).to eq true
      expect(task.reload.title).to eq 'Task 2'
    end

    it 'should not update a task' do
      task = Task.create!(
        title: 'Task 1',
        description: 'Description 1',
        expires_at: Time.now,
        status: :pending
      )

      expect(task.update(title: 'T')).to eq false
      expect(task.reload.title).to eq 'Task 1'
    end
  end

  context '#destroy' do
    it 'should destroy a task' do
      task = Task.create!(
        title: 'Task 1',
        description: 'Description 1',
        expires_at: Time.now,
        status: :pending
      )

      expect(task.destroy).to eq task
    end
  end
end
