require 'rspec'
require_relative '../rental'
require 'json'

RSpec.describe Rental do
  let(:date) { '2023-06-29' }
  let(:book) { instance_double('Book', id: 1, rentals: []) }
  let(:person) { instance_double('Person', id: 1, rentals: []) }

  subject(:rental) { Rental.new(date, book, person) }

  describe '#initialize' do
    it 'sets the date, book, and person' do
      expect(rental.date).to eq date
      expect(rental.book).to eq book
      expect(rental.person).to eq person
    end

    it 'adds the rental to the book and person' do
      expect(book.rentals).to include rental
      expect(person.rentals).to include rental
    end
  end

  describe '#to_json' do
    it 'returns a JSON representation of the rental' do
      json = {
        'date' => date,
        'book_id' => book.id,
        'person_id' => person.id
      }.to_json

      expect(JSON.parse(rental.to_json)).to eq JSON.parse(json)
    end
  end
end
