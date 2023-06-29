require 'rspec'
require_relative '../book'
require 'json'

RSpec.describe Book do
  let(:book) { Book.new('Title', 'Author') }

  describe '#initialize' do
    it 'creates a new book with title and author' do
      expect(book.title).to eq('Title')
      expect(book.author).to eq('Author')
      expect(book.rentals).to be_empty
      expect(book.id).not_to be_nil
    end
  end

  describe '.increment_id_counter' do
    it 'increments the id counter' do
      expect { Book.increment_id_counter }.to change { Book.id_counter }.by(1)
    end
  end

  describe '#to_json' do
    it 'returns the book data in JSON format' do
      json = book.to_json
      json_hash = JSON.parse(json) # Convert JSON string to a hash

      expect(json_hash['title']).to eq('Title')
      expect(json_hash['author']).to eq('Author')
      expect(json_hash['id']).not_to be_nil
    end
  end
end
