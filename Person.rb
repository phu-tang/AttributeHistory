require './AttributeHistory'
class Person
  include AttributeHistory
  attr :name, :dob

  def initialize(name, dob)
    @name = name
    @dob = dob
  end

end


a = Person.new("a","b")
puts a.name
puts a.dob

a.name = "1"

puts a.name

puts a.dob_was.to_s
puts a.dob_changed?

puts a.name_was
puts a.name_changed?

