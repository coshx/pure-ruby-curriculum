# Below you'll see an example of inheritance.
# Class Dog inherits from Class Animal.
# Try loading files and typing Dog.is_multicellular?
# What do you now know about inheritance? 
class Dog < Animal

  # Try typing Dog.is_multicellular?
  # Do you get a result?
  # Why do you get a result even though we haven't defined is_multicellular in the Dog class?
  
  # Below you'll see an example of composition.
  # Class Dog uses all methods available in a Module called "DogSkills"
  include DogSkills 

  # What might attr_accessor do?
  attr_accessor :name, :age
  
  # Can you make a dog named Buck who is 3 years old?
  # You are effectively creating an 'instance' of the Dog Class.
  def initialize(name, age)
    @name = name
    @age = age
  end

  # Try typing Dog.description.
  # What do you think super does?
  def self.description
    super
    "A usually furry, carnivorous member of the canidae family."
  end

  # Try typing "Dog.owner_says"
  # Why doesn't it work?
  # Try calling owner_says on your instance of Dog (Buck)
  # Why do you get a different result?
  def owner_says
    "My dog's name is #{@name} and he is #{@age}."
  end
  
  # How is the speak method different from the owner_says method?
  def self.speak
    # This is how you access variables in Modules
    puts DogSkills::THINGS_DOGS_SAY.sample
  end

end
