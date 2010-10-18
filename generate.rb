require 'rubygems'
require 'gslng'
require 'rsruby'

class Variable
  @generator
  def initialize(&generator)
     @generator = generator
  end
  def method_missing(property, *args)
    a = aa = args.first
    if a.class != Variable
      a = Variable.new {|| aa}
    end
    Variable.new { || self.generate().method(property).call(a.generate()) }     
  end
  def generate(n=1)
    if n == 1
       ret = @generator.call()
    else
      ret = []
      n.times{ret << self.generate().to_a}
    end
    ret
  end
end


r = RSRuby.instance
a =  Variable.new {|| r.rnorm(1)}
c= a + 2
p c.generate(1)


n = 10

w = GSLng::Matrix[ 1, 3, 1, 0]

beta = 1.0
eps = GSLng::Matrix[r.rnorm(n)].transpose * 1.0/beta

x = GSLng::Matrix.random(n, 4)
t = x * w.transpose + eps

vx = Variable.new {|| GSLng::Matrix[r.runif(4)]}
veps =  Variable.new {|| r.rnorm(1) / beta}

vt = vx * w.transpose + veps

p vt.generate(3)

