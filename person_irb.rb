RUBY_DESCRIPTION # => "ruby 2.6.0preview3 (2018-11-06 trunk 65578) [x86_64-darwin14]"

class Person; end

obj = Person.new          # => #<Person:0x00007fbbf318a1a8>

obj.class                 # => Person
Person.superclass         # => Object


class Person
  def initialize(name) # !> previous definition of initialize was here
    @name = name
  end
end

matz = Person.new('matz') # => #<Person:0x00007fbbf3189078 @name="matz">

class Person
  attr_reader :name
end

matz.name                 # => "matz"


class Person
  def initialize(name, born = nil) # !> method redefined; discarding old initialize
    @name, @born = name, born
  end
  attr_accessor :born
end

matz.methods.map(&:to_s).grep(/born/)  # => ["born", "born="]

require 'date'

matz.born = Time.local(1965, 4, 14)
dhh = Person.new('dhh', DateTime.new(1979, 10, 15, 0, 0, 0, "+01:00"))

matz.born                       # => 1965-04-14 00:00:00 +0900
dhh.born                        # => #<DateTime: 1979-10-15T00:00:00+01:00 ((2444161j,82800s,0n),+3600s,2299161j)>


class Person
  def age
    (Time.now.strftime('%Y%m%d').to_i - @born.strftime('%Y%m%d').to_i) / 1_00_00
  end
end

matz.age                        # => 53
dhh.age                         # => 39


matz.to_s                       # => "#<Person:0x00007fbbf3189078>"

class Person
  def to_s
    "#{@name}(#{age})"
  end
end

matz.to_s                       # => "matz(53)"
dhh.to_s                        # => "dhh(39)"

class Person
  def inspect
    to_s
  end
end

person = Marshal.load(Marshal.dump matz) # => matz(53)

person == dhh                   # => false
person == matz                  # => false


class Person
  include Comparable
  def <=> o
    @name <=> o.name
  end
end

person == dhh                   # => false
person == matz                  # => true
matz > dhh                      # => true


people = [matz, dhh]

people.sort                     # => [dhh(39), matz(53)]


people.sort_by(&:age)           # => [dhh(39), matz(53)]


people.sort{|a, b|b.age <=> a.age} # => [matz(53), dhh(39)]
people.sort_by{|p| -p.age}         # => [matz(53), dhh(39)]
people.sort_by{|p| p.born.to_time} # => [matz(53), dhh(39)]
people.sort_by(&:age).reverse      # => [matz(53), dhh(39)]


h = {matz => "Ruby", dhh => "Rails"}

h[matz]                         # => "Ruby"
h[dhh]                          # => "Rails"

key = Marshal.load(Marshal.dump matz)

key == matz                     # => true
h[key]                          # => nil


class Person
  def hash
    [@name, @born].hash
  end
end

matz.hash                       # => 4410064719590551442
dhh.hash                        # => -3985013288562978073
key.hash                        # => 4410064719590551442


class Person
  def eql? o
    [@name, @born].eql? [o.name, o.born]
  end
end

key.eql? matz                   # => true
key.eql? dhh                    # => false


h.rehash

h[matz]                         # => "Ruby"
h[dhh]                          # => "Rails"

h[key]                          # => "Ruby"
