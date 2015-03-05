module DogSkills

  THINGS_DOGS_SAY = ["Woof", "Squeakkk", "Yawwwn", "Pant"]

  def jumps
    "Dog jumps up and down."
  end

  # When is @name populated? and when is it not?
  # Hint: Try playing with include and extend in the toydog.rb or dog.rb file,
  # calling the fetches_ball method on an instance vs. the class!
  def fetches_ball
    "#{@name} runs, finds the ball, and brings it back!"
  end

end
