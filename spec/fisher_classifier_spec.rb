require 'spec_helper'

def create_classifier
  Classifier::FisherClassifier.new(Classifier::DataProvider::MemoryDataProvider.new)
end

describe 'FisherClassifier' do
  it 'should return an array' do
    fc = create_classifier
    fc.get_features("this is an array").should == ['this', 'array']
  end
  
  it 'show some probs for test' do
    fc = create_classifier
    sample_train(fc)
    puts fc.fisher_prob('quick rabbit', 'good')
    puts fc.fisher_prob('quick rabbit', 'bad')
  end
  
  it 'should test some thing well' do
    fc = create_classifier
    sample_train(fc)
    fc.classify('quick rabbit').should == 'good'
    fc.classify('quick money').should == 'bad'
  end
end
