require 'rspec'
require_relative '../student'
require 'json'

RSpec.describe Student do
  describe '#play_hooky' do
    it 'returns a shrug emoticon' do
      student = Student.new
      expect(student.play_hooky).to eq '¯\\(ツ)/¯'
    end
  end

  describe '#to_json' do
    it 'returns a JSON representation of the student object' do
      student = Student.new('John Doe', 16)
      json = {
        'name' => 'John Doe',
        'age' => 16,
        'parent_permission' => true,
        'type' => 'student'
      }.to_json

      expect(student.to_json).to eq json
    end
  end
end
