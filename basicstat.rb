module Basicstat
    def order_statistics
      h = Hash.new {|h,k| h[k] = 0}
      collect{|v| h[v] += 1 }
      res = h.sort
      [res.collect{|el| el[0]}, res.collect{|el| el[1]}]
    end
    
    def median
      ncut = length.to_f / 2.0
      val, valcount = order_statistics
      #p "self", self,"val", val, "valcount", valcount
      down, up, wdown, wup = valcount.cut(ncut)
      #p "s",down, up, wdown, wup, "f"
      #p "res", self[down], self[up]
      wdown * val[down] + wup * val[up]
    end

    def quartile(f)
      a = order_statistics()
      a.cut(a.length.to_f / 2)
    end

    #vaut 0 en x1, 1 en x2
    def interp(x1, x2)
      x1 = x1.to_f
      x2 = x2.to_f
      lambda{ |x| x2 != x1 ? ([x - x1, 0].max - [x - x2, 0].max ) / (x2 - x1) : 1}
    end
    
    #returns the 2 indexes i, j such that sum(el[o..i]) <= n < sum(el[o..j])
    #along with the weight so that
    def cut(alpha)
      i_last = i = 0
      underi_last = underi = 0
      
      while i < self.length - 1  && underi + self[i] / 2.0 < alpha do
        underi_last = underi
        i_last = i
        
        underi += self[i]
        i += 1
      end

      wx2 = interp(underi_last + self[i_last] / 2.0 , underi + self[i] / 2.0 ).call(alpha)
      wx1 = 1 - wx2
#      p "cut", underi_last, underi, alpha, i           
      [i_last, i, wx1, wx2 ] 
    end
end



class Array
  include Basicstat
end
 