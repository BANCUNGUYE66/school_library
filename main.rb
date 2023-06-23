require_relative 'capitalize_decorator'
require_relative 'trimmer_decorator'
require_relative 'app'

puts 'Welcome to the School Library App!'
app = App.new
app.main
