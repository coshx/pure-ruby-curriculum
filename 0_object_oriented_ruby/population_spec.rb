require "pry"
require "./population.rb"

class Animal
  include Population
end

class Kangaroo < Animal
end

class CaptainKangaroo < Kangaroo
end


RSpec.describe "Counting populations of classes" do
  after do
    [Animal, Kangaroo, CaptainKangaroo].each do |klass|
      klass.instance_variable_set("@population", 0)
    end
  end

  it "Counts the population of subclasses, also" do
    expect(Animal.population).to eq(0)
    expect(Kangaroo.population).to eq(0)
    expect(CaptainKangaroo.population).to eq(0)

    Kangaroo.new

    expect(Kangaroo.population).to eq(1)
    expect(Animal.population).to eq(1)
    expect(CaptainKangaroo.population).to eq(0)

    Animal.new

    expect(Animal.population).to eq(2)
    expect(Kangaroo.population).to eq(1)
    expect(CaptainKangaroo.population).to eq(0)

    CaptainKangaroo.new

    expect(Animal.population).to eq(3)
    expect(Kangaroo.population).to eq(2)
    expect(CaptainKangaroo.population).to eq(1)
  end

  it "Counts the population of the top-most class" do
    expect(Animal.population).to eq(0)

    Animal.new

    expect(Animal.population).to eq(1)
    expect(Animal.population).to eq(1)

    Animal.new

    expect(Animal.population).to eq(2)
  end

  it "#population should NOT be defined on an instance of Animal" do
    expect(Animal.new.respond_to?(:population)).to eq(false)
  end
end
