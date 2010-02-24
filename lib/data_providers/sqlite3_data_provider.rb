module Classifier
  module DataProvider
    class Sqlite3DataProvider
      require 'sqlite3'
      include Base
      
      DATABASE_FILE_NAME = 'classifier.db'
      DATABASE_PATH = File.dirname(__FILE__) + '/../../db/' + DATABASE_FILE_NAME
      
      def initialize
        @sqlite3_db = SQLite3::Database.new(DATABASE_PATH)
        @sqlite3_db.type_translation = true
      end
  
      def incf(f, cat)
        count = fcount(f, cat)
        if count == 0
          @sqlite3_db.execute("insert into features values(?, ?, 1)", f, cat)
        else
          @sqlite3_db.execute("update features set count=? where feature=? and category=?", count+1, f, cat)
        end
      end
  
      def fcount(f, cat)
        res = @sqlite3_db.execute("select count from features where feature=? and category=?", f, cat).first
        if res.nil?
          return 0.0
        else
          return (res[0]).to_f
        end
      end
      
      def incc(cat)
        count = catcount(cat)
        if count == 0
          @sqlite3_db.execute("insert into categories values(?, 1)", cat)
        else
          @sqlite3_db.execute("update categories set count=? where category=?", count+1, cat)
        end
      end
      
      def catcount(cat)
        res = @sqlite3_db.execute("select count from categories where category=?", cat).first
        if res.nil?
          return 0.0
        else
          return (res[0]).to_f
        end
      end
  
      def total_count
        res = @sqlite3_db.execute("select sum(count) from categories").first
        if res.nil?
          return 0
        else
          return (res[0])
        end
      end
  
      def categories
        res = @sqlite3_db.execute("select category from categories")
        res.map { |row| row[0] }
      end
      
      def self.migrate
        sqlite3_db = SQLite3::Database.new(DATABASE_PATH)
        sqlite3_db.execute("create table if not exists features(feature varchar2(22), category varchar2(22), count int)")
        sqlite3_db.execute("create table if not exists categories(category varchar2(22), count int)")
      end
      
      def self.clear
        sqlite3_db = SQLite3::Database.new(DATABASE_PATH)
        sqlite3_db.execute("delete from features")
        sqlite3_db.execute("delete from categories")
      end
    end
  end
end