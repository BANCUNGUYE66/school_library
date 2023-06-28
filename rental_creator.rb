require_relative 'book'
require_relative 'person'
require_relative 'rental'
require 'date'

class RentalCreator
  def initialize(books, people, rentals)
    @books = books
    @people = people
    @rentals = rentals
  end

  def create_rental
    puts 'Select a book from the following list by number:'
    BookList.new(@books).list_all_books
    book_index = gets.chomp.to_i - 1
    book = @books[book_index]

    puts 'Select a person from the following list by number (not ID):'
    PeopleList.new(@people).list_all_people
    person_index = gets.chomp.to_i - 1
    person = @people[person_index]

    if book.nil?
      puts 'Invalid book selection.'
    elsif person.nil?
      puts 'Invalid person selection.'
    else
      create_rental_for_book_and_person(book, person)
    end
  end

  private

  def create_rental_for_book_and_person(book, person)
    puts 'Date (yyyy/mm/dd):'
    date_input = gets.chomp
    rental_date = ::Date.parse(date_input)

    rental = Rental.new(rental_date, book, person)
    @rentals << rental
    puts 'Rental created successfully.'
  end
end
