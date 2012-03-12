## Goon ##


<pre>
require 'goon'
require 'goon/competency'
require 'goon/heist'
require 'json'

competencies = []

# The following are well-formed competencies. Those that are not well-formed
# raise Competency::InvalidCompetency
competencies << Competency.new(
  :name => 'hello',
  :description => "Say hello",
  :body => "puts 'hello'"
)

competencies << Competency.new(
  :name => 'parrot',
  :description => "Repeat after me, Polly",
  :body => "puts options[:phrase]"
)

heist = Heist.new(
  :name => 'The Stinky Teen Job',
  :body => <<-EOS 
  hello
  hello
  hello
  hello
  puts 'with the lights down'
  parrot :phrase => "it's less dangerous"
  EOS
)

my_goon = Goon.new(:competencies => competencies, :heist => heist)
puts "## Running the '#{heist.name}' heist ..."
goon_results = my_goon.run
puts "## Finished the '#{heist.name}' heist"

# Since the goon was not instructed to remember anything, an empty hash is
# returned.

puts "## '#{heist.name}' Results: #{goon_results.to_json}"
puts

heist = Heist.new(
  :name => 'Remember Remember',
  :body => <<-EOS
  puts "remembering the date"
  remember :when => '1605-11-05'
  puts "remembering the act"
  remember :what => 'The Gunpowder (Treason and) Plot'
  EOS
)

my_goon = Goon.new(:heist => heist)

puts "## Running the '#{heist.name}' heist ..."

goon_results = my_goon.run

puts "## Finished the '#{heist.name}' heist"

# Since the goon was told to remember things, we get back a non-empty hash.

puts "## '#{heist.name}' Results: #{goon_results.to_json}"
</pre>
