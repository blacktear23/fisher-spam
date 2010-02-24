module Classifier
  module DataProvider
    class MemoryDataProvider
      include Base
    
      def initialize
        @cc = {}
        @cc.default = 0
        @fc = {}
      end
    
      def incc(cat)
        @cc[cat] += 1
      end
  
      def incf(f, cat)
        @fc[f] ||= {}
        @fc[f].default = 0
        @fc[f][cat] += 1
      end
  
      def fcount(f, cat)
        if @fc.has_key?(f) && @fc[f].has_key?(cat)
          return @fc[f][cat].to_f
        end
        0.0
      end
  
      def catcount(cat)
        if @cc.has_key?(cat)
          return @cc[cat].to_f
        end
        0.0
      end
  
      def total_count
        @cc.values.reduce(:+)
      end
  
      def categories
        @cc.keys
      end  
    end
  end
end