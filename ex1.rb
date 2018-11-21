require_relative 'person'

class Person
  attr_accessor :height, :weight

  protected :weight
end

if $0 == __FILE__
  kazuhiko= Person.new('kazuhiko', Time.local(1972, 5, 8))
  kazuhiko.height = 188
  kazuhiko.weight =  59

  kazuhiko.age                  # => 46
  kazuhiko.height               # => 188
  kazuhiko.weight               # => 
end
# ~> -:16:in `<main>': protected method `weight' called for #<Person:0x00007fd2a30102e8> (NoMethodError)
# ~> Did you mean?  weight=
# ~>                height
# ~>                height=
