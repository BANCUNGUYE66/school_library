require_relative 'person'

class Student < Person
  def initialize(name = 'Unknown', age = nil, parent_permission: true)
    super(name, age, parent_permission: parent_permission)
  end

  def play_hooky
    '¯\\(ツ)/¯'
  end
end
