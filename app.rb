require_relative 'person'
require_relative 'student'
require_relative 'teacher'
require_relative 'book'
require_relative 'rental'
require_relative 'menu'
require 'json'

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

  def save_data
    save_books
    save_people
    save_rentals
  end

  def load_data
    load_books
    load_people
    load_rentals
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

  def save_books
    File.write('books.json', JSON.generate(books))
  end

  def load_books
    return unless File.exist?('books.json')

    books_data = File.read('books.json')
    @books = JSON.parse(books_data).map do |book_data|
      Book.new(book_data['title'], book_data['author'])
    end
  end

  def save_people
    people_data = people.map do |person|
      data = {
        'name' => person.name,
        'age' => person.age,
        'type' => person.class.name,
        'id' => person.id
      }
      data['parent_permission'] = person.parent_permission if person.is_a?(Student)
      data['specialization'] = person.specialization if person.is_a?(Teacher)
      data
    end

    File.write('people.json', JSON.pretty_generate(people_data))
  end

  def load_people
    return unless File.exist?('people.json')

    people_data = File.read('people.json')
    people_array = JSON.parse(people_data)

    @people = people_array.map do |person_data|
      if person_data['type'] == 'Student'
        Student.new(person_data['name'], person_data['age'], parent_permission: person_data['parent_permission'])
      elsif person_data['type'] == 'Teacher'
        Teacher.new(person_data['name'], person_data['age'], person_data['specialization'],
                    parent_permission: person_data['parent_permission'])
      else
        Person.new(person_data['name'], person_data['age'], parent_permission: person_data['parent_permission'])
      end
    end
  end

  def save_rentals
    rentals_data = @rentals.map(&:to_json)
    File.write('rentals.json', JSON.pretty_generate(rentals_data))
  end

  def load_rentals
    return unless File.exist?('rentals.json')

    rentals_data = File.read('rentals.json')
    begin
      rentals_json = JSON.parse(rentals_data)
      @rentals = rentals_json.map do |rental_data|
        book_id = rental_data['book_id']
        person_id = rental_data['person_id']

        book = find_book_by_id(book_id)
        person = find_person_by_id(person_id)

        Rental.new(rental_data['date'], book, person) if book && person
      end.compact
    rescue JSON::ParserError => e
      puts "Error parsing rentals.json: #{e.message}"
    end
  end

  def find_book_by_id(id)
    books.find { |book| book.id == id }
  end

  def find_person_by_id(id)
    people.find { |person| person.id == id }
  end
end
