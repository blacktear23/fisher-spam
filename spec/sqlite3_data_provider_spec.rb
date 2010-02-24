require 'spec_helper'

SDP = Classifier::DataProvider::Sqlite3DataProvider

describe 'SQLite3DataProvider test' do
  it "should create tables" do
    SDP.migrate
    db = SQLite3::Database.new(SDP::DATABASE_PATH)
    proc {
      db.execute("select * from features")
      db.execute("select * from categories")
    }.should_not raise_exception
  end
  
  it "should trained" do
    SDP.clear
    dp = SDP.new
    sample_train(dp)
    dp.categories.length.should > 0
  end
  
  it "should return bad when pass 'quick money'" do
    Classifier.classify("quick money").should == "bad"
  end
end
