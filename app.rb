require_relative 'person'
require_relative 'student'
require_relative 'teacher'
require_relative 'book'
require_relative 'rental'
require_relative 'capitalize_decorator'
require_relative 'trimmer_decorator'
require 'date'

class App
  attr_reader :people, :books, :rentals

  def initialize
    @people = []
    @books = []
    @rentals = []
  end

  def add_student(student)
    people << student
  end

  def list_all_books
    puts 'List of Books:'
    books.each_with_index do |book, index|
      puts "#{index + 1}. Title: \"#{book.title}\", Author: \"#{book.author}\""
    end
  end

  def list_all_people
    puts 'List of People:'
    people.each_with_index do |person, index|
      person_type = person.is_a?(Student) ? 'Student' : 'Teacher'
      puts "#{index + 1}. [#{person_type}]  Name: #{person.name}, ID: #{person.id}, Age: #{person.age}"
    end
  end

  def create_person
    puts 'Do you want to create a student(1) or a teacher (2)? [Input the number]:'
    person_type = gets.chomp.to_i

    puts 'Age:'
    age = gets.chomp.to_i

    puts 'Name:'
    name = gets.chomp

    case person_type
    when 1
      create_student(name, age)
    when 2
      create_teacher(name, age)
    else
      puts 'Invalid person type.'
      return
    end

    puts 'Person created successfully.'
  end

  def create_book
    puts 'Title:'
    title = gets.chomp
    puts 'Author:'
    author = gets.chomp

    book = Book.new(title, author)
    books << book
    puts 'Book created successfully.'
  end

  def create_rental
    puts 'Select a book from the following list by number:'
    list_all_books
    book_index = gets.chomp.to_i - 1
    book = books[book_index]

    puts 'Select a person from the following list by number (not ID):'
    list_all_people
    person_index = gets.chomp.to_i - 1
    person = people[person_index]

    if book.nil?
      puts 'Invalid book selection.'
    elsif person.nil?
      puts 'Invalid person selection.'
    else
      create_rental_for_book_and_person(book, person)
    end
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
    loop do
      print_menu
      choice = gets.chomp.to_i

      break if choice == 7

      process_choice(choice)
    end
  end

  private

  def process_choice(choice)
    case choice
    when 1
      list_all_books
    when 2
      list_all_people
    when 3
      create_person
    when 4
      create_book
    when 5
      create_rental
    when 6
      list_rentals_for_person
    else
      puts 'Invalid choice. Please try again.'
    end
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

  def find_person(id)
    people.find { |person| person.id == id }
  end

  def find_book(id)
    books.find { |book| book.id == id }
  end

  def create_student(name, age)
    puts 'Has parent permission? [Y/N]:'
    parent_permission = gets.chomp.downcase == 'y'

    student = Student.new(name, age, parent_permission: parent_permission)
    add_student(student)
  end

  def create_teacher(name, age)
    puts 'Specialization:'
    specialization = gets.chomp

    teacher = Teacher.new(name, age, specialization)
    add_student(teacher)
  end

  def create_rental_for_book_and_person(book, person)
    puts 'Date (yyyy/mm/dd):'
    date_input = gets.chomp
    date = Date.parse(date_input)

    rental = Rental.new(date, book, person)
    rentals << rental
    puts 'Rental created successfully.'
  end

  def list_person_rentals(person)
    person_rentals = rentals.select { |rental| rental.person == person }

    person_rentals.each do |rental|
      puts "Rental: Date: #{rental.date}, Book: \"#{rental.book.title}\" by #{rental.book.author}"
    end
  end
end

app = App.new
app.main
