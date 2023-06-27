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
      'date' => date,
      'book_id' => book.id,
      'person_id' => person.id
    }
  end
end
