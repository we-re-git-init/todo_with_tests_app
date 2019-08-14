require 'rails_helper'

RSpec.describe Task, type: :model do
  describe '#toggle_complete!' do
    it 'should change complete status from false to true' do
      task = Task.create!(complete: false)
      task.toggle_complete!
      expect(task.complete).to eq(true)
    end
    it 'should change complete status from true to false' do
      task = Task.create!(complete: true)
      task.toggle_complete!
      expect(task.complete).to eq(false)
    end
  end
  describe '#overdue?' do
    it 'will return true if the deadline is in the past' do
      task = Task.create(deadline: Time.now - 5.days)
      expect(task.overdue?).to eq(true)
    end
    it 'will return false if the deadline is in the future' do
      task = Task.create(deadline: Time.now + 5.days)
      expect(task.overdue?).to eq(false)
    end
  end
  describe '#increment_priority!' do
    it 'should add 1 to the priority if the priority is less than 10' do
      task = Task.create!(priority: 4)
      task.increment_priority!
      expect(task.priority).to eq(5)
    end
    it 'should keep priority the same if priority is currently at 10' do
      task = Task.create(priority: 10)
      task.increment_priority!
      expect(task.priority).to eq(10)
    end
  end
  describe '#snooze_hour!' do
    it 'should add one hour to the deadline' do
      current_time = Time.now
      task = Task.create(deadline: current_time)
      task.snooze_hour!
      expect(task.deadline).to eq(current_time + 1.hours)
    end
  end
end
