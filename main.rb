require_relative 'app'
require_relative 'menu'

app = App.new
app.load_data

menu = Menu.new(app)

loop do
  menu.print_menu
  choice = gets.chomp.to_i

  break if choice == 7

  menu.process_choice(choice)
end
