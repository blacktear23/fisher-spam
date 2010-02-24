require 'spec_helper'

describe 'Classifier' do
  it 'should train fisher classifier' do
    Classifier.train("this is a test", 'good')
    Classifier.instance.categories.length.should > 0
  end
  
  it 'should return bad with "quick money" ' do
    sample_train(Classifier.instance)
    Classifier.classify("quick money").should == "bad"
  end
end