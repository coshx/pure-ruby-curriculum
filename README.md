#Ruby Training
###Curriculum Outline
Gabe Kopley, Instructor

####Pre-work Preparation

- Ruby 2.2.0 installed via Ruby Version Manager (rvm)
  - (this will include RubyGems and the gem command)
  - rvm allows easily developing in arbitrary Ruby versions; during the class I will point out features and tricks of rvm.
  - Ruby 2.2.0 is not strictly required, but highly recommended, as installing it will motivate exploring the usefulness of rvm (there are no drastic differences between Ruby 2.1.x and Ruby 2.2.0).
- Selected readings TBD

####Format

- "Code-along": I will lead the class from my own machine while projecting my code and its output.
- Pace: This class is for experienced developers. I will generally move fast, rationing our time to investigate interesting subjects that come up along the way.
- Incidental mini-topics: I will encourage participants to interrupt me to ask pertinent questions, which I will answer by relating to the experience of the student in other programming languages. However I will be careful to keep the class moving and avoid lengthy digressions.

####Lesson 0: Basic Object-Oriented Ruby

- Goal: Run through the minimum subset of the Ruby language that relates to Object-Oriented program design.
- Topics: class vs. module, include vs. extend, what is self, inheritance vs. composition
- Exercise: We will model Animals and Dogs, even ToyDogs.
- Time: 3 hours

####Lesson 1: TDD/BDD with RSpec

- Goal: Get up and running with the RSpec behavior-driven testing framework.
- Topics: Ruby gems, reflection, "Test-first development", the pry interactive debugger, accessing the filesystem, Ruby's blocks, deciding what to test, fundamental Ruby data structures
- Exercise: While writing tests first, we will create a program that generates a histogram of the number of instances of each character in an input file.
- Time: 3 hours

####Lesson 2: Transforming and Reducing A Text Stream

- Goal: Use Ruby to create programs the work in a Unix pipeline.
- Topics: rake, several ways of executing system commands from Ruby.
- Exercise: We will write a program that counts the number of occurrences of a search string in an text dump of Wikipedia.
- Time: 2 hours

####Lesson 3: Writing Command Line Tools

- Goal: Learn how to quickly develop flexible command line tools in Ruby
- Topics: Resources and metrics for evaluating Ruby gems. Quick solutions to common requirements for command line programs.
- Exercise: We will augment our program from Lesson 2 to support slurping text from stdin or from a passed-in filename, and add one or two features attached to command line options.
- Time: 3 hours

####Lesson 4: Tricks of the pry interactive debugger

- Goal: Learn practical tricks to experiment with ease
- Topics: pry plugins
- Exercise: We will explore a complicated nested data structure obtained by parsing JSON
- Time: 1 hour

####Lesson 5: Yaml, why and how?

- Goal: Understand when Yaml is a good choice of serialization format, and how to make the most of its features.
- Topics: Appending and streaming Yaml data. Ruby data structures.
- Exercise: We will make a series of HTTP requests that returns JSON, and incrementally parse and dump the responses to a Yaml file, including helpful metadata. Then we will stream and reduce the Yaml file we just created.
- Time: 1-2 hours

####Lesson 6: Build a Custom Parser Library

- Goal: Best practices in authoring Ruby parser libraries
- Topics: Idiomatic use of regexes in Ruby. Using a Ruby-based PEG parser-generator. OO design. Writing and using custom Ruby Gems.
- Exercise: We will write a parser for HTTP URIs.
- Time: 4 hours

####Lesson 7: A Peek at Meta-Programming

- Goal: Inspire students with the possibilities of Ruby's powerful meta-programming facilities.
- Topics: method_missing, monkey patching, lambdas/procs, Domain-Specific Languages (DSLs)
- Exercise: TBD
- Time: 0+ hours (whatever time is left over)

####Reference Texts
- [Eloquent Ruby](http://www.amazon.com/Eloquent-Ruby-Addison-Wesley-Professional-Series/dp/0321584104) (language reference)
- [Practical Object-Oriented Design in Ruby](http://www.amazon.com/Practical-Object-Oriented-Design-Ruby-Addison-Wesley/dp/0321721330) (design patterns)
