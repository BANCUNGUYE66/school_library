require_relative 'person'
require_relative 'student'
require_relative 'teacher'
require_relative 'book'
require_relative 'rental'
require_relative 'menu'

class App
  attr_reader :people, :books, :rentals

  def initialize
    @people = []
    @books = []
    @rentals = []
    @menu = Menu.new(self)
  end

  def add_student(student)
    people << student
  end

  def create_rental
    @menu.process_choice(5)
  end

  def list_rentals_for_person
    puts 'Enter person ID:'
    person_id = gets.chomp.to_i

    person = find_person(person_id)

    if person.nil?
      puts "Person with ID #{person_id} not found."
    else
      list_person_rentals(person)
    end
  end

  def main
    puts 'Welcome to the School Library App!'

    loop do
      @menu.print_menu
      choice = gets.chomp.to_i

      break if choice == 7

      @menu.process_choice(choice)
    end
  end

  private

  def find_person(id)
    people.find { |person| person.id == id }
  end

  def list_person_rentals(person)
    person_rentals = rentals.select { |rental| rental.person == person }

    person_rentals.each do |rental|
      puts "Rental: Date: #{rental.date}, Book: \"#{rental.book.title}\" by #{rental.book.author}"
    end
  end
end
