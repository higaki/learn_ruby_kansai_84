require_relative 'person'

class Person
  attr_accessor :height
  attr_writer   :weight
end

if $0 == __FILE__
  kazuhiko= Person.new('kazuhiko', Time.local(1972, 5, 8))
  kazuhiko.height = 188
  kazuhiko.weight =  59

  kazuhiko.age                  # => 46
  kazuhiko.height               # => 188
  kazuhiko.weight               # => 
end
# ~> -:15:in `<main>': undefined method `weight' for #<Person:0x00007fbcc0955e00> (NoMethodError)
# ~> Did you mean?  weight=
# ~>                height
# ~>                height=
