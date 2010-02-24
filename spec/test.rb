require 'spec_helper'

fc = FisherClassifier.new
sample_train(fc)
puts fc.inspect

puts fc.fisher_prob('quick rabbit', 'good')