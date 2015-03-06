class Animal
  include Population

  def initialize(age)
    @age = age
  end

  def description
    "A multicellular, eukaryotic organism of the kingdom Animalia."
  end

  def is_multicellular?
    true
  end
end
