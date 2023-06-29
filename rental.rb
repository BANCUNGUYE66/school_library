class Rental
  attr_accessor :date, :book, :person

  def initialize(date, book, person)
    @date = date
    @book = book
    @person = person
    book.rentals << self
    person.rentals << self
  end

  def to_json(*_args)
    {
      'book_id' => book.id,
      'date' => date,
      'person_id' => person.id
    }.to_json
  end
end
