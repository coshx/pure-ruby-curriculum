module Population
  # Let's use the common Ruby pattern of extending a class
  # and including instance methods on instance of the class
  # in one shot (only `include` is required, rather than
  # `include` plus `extend`)
  # cf. http://www.dan-manges.com/blog/27
  def self.included(klass)
    # A class is passed in to the `included` hook, we bind
    # it to the local variable `klass` because `class` is
    # a keyword

    # We want to modify klass heavily, so class_eval is handy
    klass.class_eval do
      # Initialize our population in a class instance variable
      @population = 0

      # Whenever klass is subclassed, we want to initialize
      # the population of the subclass. `inherited` let's
      # us hook into the subclassing events
      def self.inherited(base)
        base.class_eval do
          @population = 0
        end
      end

      # This goes along with the common Ruby pattern mentioned
      # above
      extend ClassMethods

      # `prepend` is like extend but places the module at the top
      # of the inheritance hierarchy. This is useful to use because
      # we can pass on all arguments to `initialize` and don't have
      # to worry about whether or not the classes themselves
      # pass on arguments
      prepend Initializer
    end
  end

  module Initializer
    # Override `initialize` in order to track
    # the populations of our classes
    # Take arbitrary arguments in order to stay compatible with
    # arbitary inheritance chains
    def initialize(*a, &b)
      # We must call `super` in case `initialized` has been defined
      # upward in the hierarchy
      # We call it first because we don't want to track the population
      # if super fails
      super

      # We don't just want to record a new instance of our own
      # class, but also our ancestor classes where we are
      # tracking population
      # NOTE that
      # a) `self.class.ancestors` includes `self.class`
      # b) We must use `self.class` instead of just `class` becuase
      # `class` is a keyword
      self.class.ancestors.each do |klass|
        # `respond_to?` tells us whether the method is defined on
        # the class. The 2nd argument `true` finds private methods
        if klass.respond_to?(:record_new_instance, true)
          # `send` calls private methods
          klass.send(:record_new_instance)
        end
      end
    end
  end

  # This goes along with the common Ruby pattern mentioned
  # above
  module ClassMethods
    # Define a getter for our @population instance variable
    attr_reader :population

    # Make this method private in order to keep a clean public API
    private
    def record_new_instance
      @population += 1
    end
  end
end

# Example:
#
# class Animal
#   include Population
#   ...
# end
#
# class Dog < Animal
#   ...
# end
#
# class ThreeLeggedDog < Dog
#   ...
# end
#
# > Animal.population
# => 0
# > Dog.population
# => 0
# > ThreeLeggedDog.population
# => 0
# > Dog.new("stewie", 5)
# => #<Dog:0x0000000152fe80 @age=5, @name="stewie">
# > Animal.population
# => 1
# > Dog.population
# => 1
# > ThreeLeggedDog.population
# => 0
# > ThreeLeggedDog.new("tripod", 8)
# #<ThreeLeggedDog:0x00000001fc3ba8 @age=8, @name="tripod">
# > Animal.population
# => 2
# > Dog.population
# => 2
# > ThreeLeggedDog.population
# => 1
# > Animal.new
# => #<Animal:0x000000013d2268>
# > Animal.population
# => 3
# > Dog.population
# => 2
# > ThreeLeggedDog.population
# => 1
