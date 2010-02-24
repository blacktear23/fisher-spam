module Classifier
  require 'rubygems'
  require 'sinatra/base'
  require 'erb'
  
  class FisherSpamServer < Sinatra::Base
    set :root, File.dirname(__FILE__)
  
    get '/' do
      erb :index
    end

    get '/train' do
      erb :train
    end

    get '/classify' do
      erb :classify
    end

    post '/train' do
      Classifier.train(params[:doc], params[:category])
      redirect('/train')
    end

    post '/classify' do
      Classifier.classify(params[:doc])
    end
  end
end