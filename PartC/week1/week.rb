class Hello
  def first_method
    puts "Hello, world"
  end
end

h = Hello.new
h.first_method

class B
  def m1
    42
  end

  def m2 x
    x.abs + 2 * self.m1
  end
end

# Instance and Class state

class C
  Foo = "bar" # Class constant, don't mutate it

  def initialize # Initializer
    @foo = 0  # Instance's variable; private
    @@bar = 0 # Class's variable, shared between instances; private
  end

  def m1 x
    @foo += x   # Mutate @foo only for one concrete instace 
    @@bar += 1  # Mutate @@bar across every instance of a class C
  end

  def foo # Kinda like accessor
    @foo
  end

  def bar
    @@bar
  end
