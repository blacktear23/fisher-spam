module Classifier
  class FisherClassifier < Base
    
    def initialize(data_provider)
      init_data(data_provider)
      @min = {}
    end
  
    def set_min(cat, min)
      @min[cat] = min
    end
  
    def get_min(cat)
      return 0 if @min[cat].nil?
      @min[cat]
    end
  
    def classify(item, default=nil)
      best = default
      max = 0.0
      categories.each do |c|
        p = fisher_prob(item, c)
        if p > get_min(c) && p > max
          best = c
          max = p
        end
      end
      best
    end
  
    def weighted_prob(f, cat, weight = 1.0, ap = 0.5)
      basic_prob = cprob(f, cat)
      totals = categories.map{|c| fcount(f, c) }.reduce(:+)
      bp = ((weight*ap) + (totals*basic_prob))/(weight+totals)
    end
  
    def cprob(f, cat)
      clf = fprob(f, cat)
      return 0.0 if clf == 0
    
      freqsum = categories.map{|c| fprob(f, c)}.reduce(:+)
      clf / freqsum
    end
  
    def fprob(f, cat)
      return 0 if catcount(cat) == 0
      fcount(f, cat)/catcount(cat)
    end
  
    def fisher_prob(item, cat)
      p = 1.0
      features = get_features(item)
      features.each do |f|
        p *= weighted_prob(f, cat)
      end
      fscore = -2 * Math.log(p)
      invchi2(fscore, features.length * 2)
    end
  
    def invchi2(chi, df)
      m = chi / 2.0
      sum = term = Math.exp(-m)
      (1..(df/2).to_i).each do |i|
        term *= m / i
        sum += term
      end
      [sum, 1.0].min
    end
  end
end