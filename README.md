## Goon ##

Goon is a minion that performs tasks

## Release Notes ##

* 0.0.3 - Renamed "Heist" to "Task," as that makes more sense.
* 0.0.2 - For example, our naivite caused us to think that we could cut a gem without jumping through hoops.
* 0.0.1 - Initial release. Basically usable and spec'd, but probably has some
naive implementation.

## Goons? ##

That is, a goon object, being taught the proper competencies, will perform a
valid Task and remember facts related to the process.

### .new ###

Creating a Goon is pretty easy, but a Goon created without a Task is just
about worthless. The following will actually do the trick:

    goon = Goon.new

The following, however, is a lot more useful (or would be if the Task wasn't
just terribly cordial):

    goon = Goon.new(
      :task => OpenStruct(
        :name => 'Hello!!!',
        :body => 'puts "hello"'
      )
    )

In addition to the :task option, you can pass in an array of Competency objects
with the :competencies option or a hash of facts with the :facts option.

### #learn_competency ###

A goon can be taught a new competency. The learn_competency method takes an
object conforming to the Competency API and injects it into the goon that is
learning. There is also a plural form, learn_competencies, that takes an array
of competencies.

### #remember ###

A goon can remember facts. The remember method takes a hash where the keys are
fact names and the values are the meat of the fact.

### #recall ###

A goon can recall facts that it has remembered. The recall method takes a fact name.

### #forget ###

A goon can forget facts that it has remembered. The forget method takes a fact name.

### #run ###

A goon can perform a Task. The run method takes no arguments, but returns the facts that it has remembered when it is done with the job.

## Tasks? ##

A Task, when it comes down, is any object that fits this bill:

* Has a name method that returns a non-empty string
* Has a body method that returns a non-empty string

That said, goon/task contains the Goon::Task class that will absolutely always
work with Goon, and it also validates itself on creation. Unfortunately, using
this class to make a Task means that exceptions will be raised if an invalid
name or body is provided.

### name ###

The name of a Task is just that ... it is a (preferably) unique identifier.

### body ###

The body of a Task is a snippet of code. Most typically, 

## Competencies? ##

A Competency is a skill that one can teach one's goons. Much like a Task, a
competency can be pretty much any object so long as it fits the following:

* Has a name method that returns a non-empty string
* Has a body method that returns a non-empty string

If you would like to use our reference Competency, it lives in goon/competency.
The same caveats (and then some) apply to this as do to our reference Task.

When a Goon learns a Competency, the Goon in question gains an equivalent
instance method to said Competency. So, say that we have a Competency named
"hello" with the following body:

    puts "hello"

After learning "hello," my goon will have the following method:

    def hello(options = {})
      puts "hello"
    end

As you can see, a Competency receives a hash of options so that you can pass
information into them.

### name ###

The name of a Competency is a string that could be used as a Ruby method name.
That being the case, it cannot contain spaces, it must be punctuated properly,
so on. A good rule of thumb is that if at all possible, make your Competency
name a single word without punctuation, et cetera.

### body ###

The body of a Competency is the meat of the method that is generated upon
learning the Competency. Aside from emptyness, we don't really do any checking
on this, but take our word that you absolutely want this to be valid Ruby.

## Example ##

<pre>
require 'goon'
require 'goon/competency'
require 'goon/task'
require 'json'

competencies = []

# The following are well-formed competencies. Those that are not well-formed
# raise Goon::Competency::InvalidCompetency
competencies << Goon::Competency.new(
  :name => 'hello',
  :description => "Say hello",
  :body => "puts 'hello'"
)

competencies << Goon::Competency.new(
  :name => 'parrot',
  :description => "Repeat after me, Polly",
  :body => "puts options[:phrase]"
)

task = Goon::Task.new(
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

my_goon = Goon.new(:competencies => competencies, :task => task)
puts "## Running the '#{task.name}' task ..."
goon_results = my_goon.run
puts "## Finished the '#{task.name}' task"

# Since the goon was not instructed to remember anything, an empty hash is
# returned.

puts "## '#{task.name}' Results: #{goon_results.to_json}\n"

task = Goon::Task.new(
  :name => 'Remember Remember',
  :body => <<-EOS
  puts "remembering the date"
  remember :when => '1605-11-05'
  puts "remembering the act"
  remember :what => 'The Gunpowder (Treason and) Plot'
  EOS
)

my_goon = Goon.new(:task => task)

puts "## Running the '#{task.name}' task ..."

goon_results = my_goon.run

puts "## Finished the '#{task.name}' task"

# Since the goon was told to remember things, we get back a non-empty hash.

puts "## '#{task.name}' Results: #{goon_results.to_json}"
</pre>
