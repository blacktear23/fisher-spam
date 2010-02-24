$:.unshift(File.dirname(__FILE__) + '/lib')

task :spec do
  sh 'spec spec'
end

task :gem do
  sh 'gem build *.gemspec'
end

task :migrate do
  require 'classifier'
  
  SDP = Classifier::DataProvider::Sqlite3DataProvider
  SDP.migrate
end

task :cleardb do
  require 'classifier'
  
  SDP = Classifier::DataProvider::Sqlite3DataProvider
  SDP.clear
end

task :pak => :gem

task :server do
  require 'classifier'
  Classifier::FisherSpamServer.run!
end