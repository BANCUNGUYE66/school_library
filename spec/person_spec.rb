require 'rspec'
require_relative '../person'
require 'json'
require 'date'

RSpec.describe Person do
  let(:person) { Person.new('John Doe', 25) }

  describe '#initialize' do
    it 'sets the name and age' do
      expect(person.name).to eq('John Doe')
      expect(person.age).to eq(25)
    end

    it 'generates a random ID' do
      expect(person.id).to be_an(Integer)
    end

    it 'sets the parent permission to true by default' do
      expect(person.instance_variable_get(:@parent_permission)).to eq(true)
    end

    it 'initializes an empty rentals array' do
      expect(person.rentals).to be_an(Array)
      expect(person.rentals).to be_empty
    end
  end

  describe '#can_use_services?' do
    context 'when the person is of age' do
      let(:person) { Person.new('Jane Smith', 21) }

      it 'returns true' do
        expect(person.can_use_services?).to eq(true)
      end
    end

    context 'when the person is not of age but has parent permission' do
      let(:person) { Person.new('David Johnson', 16, parent_permission: true) }

      it 'returns true' do
        expect(person.can_use_services?).to eq(true)
      end
    end

    context 'when the person is not of age and does not have parent permission' do
      let(:person) { Person.new('Amy Davis', 17, parent_permission: false) }

      it 'returns false' do
        expect(person.can_use_services?).to eq(false)
      end
    end
  end

  # Add more tests as needed for other methods and behaviors

  describe '#to_json' do
    it 'returns a JSON representation of the person' do
      json_data = person.to_json
      parsed_data = JSON.parse(json_data)

      expect(parsed_data['name']).to eq('John Doe')
      expect(parsed_data['age']).to eq(25)
      expect(parsed_data['parent_permission']).to eq(true)
      expect(parsed_data['type']).to eq('Person')
      expect(parsed_data['id']).to eq(person.id)
      expect(parsed_data['rentals']).to eq([])
    end
  end
end
