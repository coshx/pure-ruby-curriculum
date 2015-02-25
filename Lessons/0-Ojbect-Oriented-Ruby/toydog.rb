class ToyDog

  attr_accessor :name
  
  # Try changinge extend to include
  # What is different?
  extend DogSkills
  
  def self.speak
    DogSkills::THINGS_DOGS_SAY.sample
  end

end
