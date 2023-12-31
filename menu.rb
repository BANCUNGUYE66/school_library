require_relative 'book_list'
require_relative 'people_list'
require_relative 'person_creator'
require_relative 'book_creator'
require_relative 'rental_creator'

class Menu
  def initialize(app)
    @app = app
  end

  def print_menu
    puts "\nChoose an option:"
    puts '1. List all books'
    puts '2. List all people'
    puts '3. Create a person'
    puts '4. Create a book'
    puts '5. Create a rental'
    puts '6. List all rentals for a person'
    puts '7. Quit'
  end

  def process_choice(choice)
    case choice
    when 1
      BookList.new(@app.books).list_all_books
    when 2
      PeopleList.new(@app.people).list_all_people
    when 3
      PersonCreator.new(@app.people).create_person
    when 4
      BookCreator.new(@app.books).create_book
    when 5
      RentalCreator.new(@app.books, @app.people, @app.rentals).create_rental
      @app.save_data
    when 6
      @app.list_rentals_for_person
    else
      puts 'Invalid choice. Please try again.'
    end
  end
end
