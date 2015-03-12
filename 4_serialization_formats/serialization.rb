require "net/http"
require "open-uri"
require "pry"
require "json"
require "yaml"

PROTOCOL = "http"
HOST = "rssf.herokuapp.com"

# Let's look at a couple ways to make requests
#
# a) Net::HTTP - lowest level
#   May return ASCII response
response_a = Net::HTTP.get(URI.parse("#{PROTOCOL}://#{HOST}/l.json"))

#puts response_a

# b) OpenURI - slightly higher level
#   (follows redirects)
#   Ensures response is UTF-8 encoded
response_b = OpenURI.open_uri("#{PROTOCOL}://#{HOST}/l.json").read

puts "Equal? #{response_a.force_encoding("UTF-8") == response_b}"

# c) HTTParty or similar
#   https://github.com/jnunemaker/httparty
#   https://www.ruby-toolbox.com/categories/http_clients

# Parse the JSON
parsed_response = JSON.parse(response_a)

# (by the way, there is NO XML parser in
# the standard library, must use Nokogiri)
# http://www.nokogiri.org/
#
ids =
  parsed_response.map { |lesson| lesson["id"] }
                 .take(7)

full_lessons = ids.map { |id|
  response = OpenURI.open_uri("#{PROTOCOL}://#{HOST}/l/#{id}.json").read
  JSON.parse(response)
  # Right here!
}

# TODO normalize students and lessons,
# then dump them to YAML files

student_ids_written = {}

# just for example, we're not using this
def File.gabes_open(filenames, permissionses)
  open_files = filenames.each_with_index.reduce([]) do |acc, (filename, i)|
    acc << File.open(filename, permissionses[i])
    acc
  end

  yield(*open_files)

  open_files.each(&:close)
end

File.open("lessons.yml", "w") do |lessons_file|
  # we've just opened lessons

  File.open("students.yml", "w") do |students_file|
    # we've just opened students

    # We need to first write the students
    # Then replace the key lesson.students with
    # the ids of the students
    # Then write the lesson
    full_lessons.each do |lesson|
      # write whatever students we need to write
      lesson["students"].each do |student|
        unless student_ids_written[student["id"]]
          students_file.write(student.to_yaml)
          student_ids_written[student["id"]] = true
        end
      end

      # we definitely have to write the lesson
      # itself
      # But first, replace the students with their
      # ids
      lesson["students"] =
        lesson["students"].map { |student|
          student["id"]
        }

      lessons_file.write(lesson.to_yaml)
    end
  end
  # we've just closed students
end
# we've just closed lessons

# OK, now lets load the yaml files and denormalize
students = File.open("students.yml") do |file|
  YAML.load_documents(file).reduce({}) do |acc, record|
    acc.merge(record["id"] => record)
  end
end

File.open("lessons.yml") do |file|
  YAML.load_documents(file) do |record|
    record["students"] = record["students"].map { |id|
      students[id]
    }
    write_record_to_db(record)
  end
  # lessons from yaml may be garbage collected
  # between iteration
end

#puts lessons[0]
