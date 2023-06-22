require_relative 'person'
require_relative 'capitalize_decorator'
require_relative 'trimmer_decorator'
require_relative 'app'

person = Person.new(22, 'maximilianus')
puts person.correct_name

capitalized_person = CapitalizeDecorator.new(person)
puts capitalized_person.correct_name

capitalized_trimmed_person = TrimmerDecorator.new(capitalized_person)
puts capitalized_trimmed_person.correct_name

puts 'Welcome to the School Library App!'
app = App.new
app.main
