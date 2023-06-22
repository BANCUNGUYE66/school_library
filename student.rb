require_relative 'person'

class Student < Person
  attr_accessor :classroom

  def initialize(classroom, name = 'Unknown', age = nil, parent_permission: true)
    super(name, age, parent_permission: parent_permission)
    belong_to_classroom(classroom)
  end

  def play_hooky
    '¯\\(ツ)/¯'
  end

  def belong_to_classroom(classroom)
    self.classroom = classroom
    classroom.add_student(self)
  end
end
