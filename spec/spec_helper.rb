$:.unshift(File.dirname(__FILE__) + '/../lib')

require 'rubygems'
require 'spec'

require 'classifier'
Classifier.provider = :sqlite

def sample_train(classifier)
  classifier.train('Nobody owns the water.', 'good')
  classifier.train('the quick rabbit jumps fences', 'good')
  classifier.train('buy pharmaceuticals new', 'bad')
  classifier.train('make quick money at the online casino', 'bad')
  classifier.train('the quick brown fox jumps', 'good')
end