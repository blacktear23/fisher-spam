require 'spec_helper'
require 'rack/test'

describe "Server test" do
  include Rack::Test::Methods
  
  def app
    @app ||= Classifier::FisherSpamServer
  end
  
  it "should response index" do
    get '/'
    last_response.should be_ok
  end
  
  it "should response classify" do
    get '/classify'
    last_response.should be_ok
  end
  
  it "should respinse train" do
    get '/train'
    last_response.should be_ok
  end
  
  it 'should response bad when post "quick money" document' do
    post '/classify', :doc => "quick money"
    last_response.should be_ok
    last_response.body.should == "bad"
  end
  
  it 'should respinse redirect when post a train data' do
    post '/train', :doc => "fuck you", :category => "bad"
    last_response.should be_redirect
    last_response.headers['Location'].should == '/train'
  end
  
  it "should save a train data when post" do
    post '/train', :doc => "ass hole", :category => "bad"
    last_response.should be_redirect
    post '/classify', :doc => 'ass hole'
    last_response.body.should == 'bad'
  end
end