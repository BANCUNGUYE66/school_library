require 'rspec'
require_relative '../teacher'
require 'json'

RSpec.describe Teacher do
  describe '#can_use_services?' do
    it 'returns true for teacher' do
      teacher = Teacher.new
      expect(teacher.can_use_services?).to be true
    end
  end

  describe '#to_json' do
    it 'returns a JSON representation of the teacher object' do
      teacher = Teacher.new('Jane Smith', 35, 'Math')
      json = {
        'name' => 'Jane Smith',
        'age' => 35,
        'parent_permission' => true,
        'type' => 'teacher',
        'specialization' => 'Math'
      }.to_json

      expect(teacher.to_json).to eq json
    end
  end
end
