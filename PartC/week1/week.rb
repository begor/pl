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