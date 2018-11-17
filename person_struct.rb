RUBY_DESCRIPTION # => "ruby 2.6.0preview3 (2018-11-06 trunk 65578) [x86_64-darwin14]"
require 'date'

Person = Struct.new(:name, :born)

matz = Person.new('matz')
dhh  = Person.new('dhh', DateTime.new(1979, 10, 15, 0, 0, 0, "+01:00"))

person = Marshal.load(Marshal.dump matz)

person == matz                  # => true
person == dhh                   # => false

h = {matz => "Ruby", dhh => "Rails"}

key = Marshal.load(Marshal.dump matz)

h[matz]                         # => "Ruby"
h[dhh]                          # => "Rails"

h[key]                          # => "Ruby"


class Person
  def age
    (Time.now.strftime('%Y%m%d').to_i - born.strftime('%Y%m%d').to_i) / 1_00_00
  end
end

dhh.age                         # => 39
