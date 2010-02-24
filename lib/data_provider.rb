module Classifier
  module DataProvider
    module Base
      def get_features(doc)
        words = doc.split(/\W/).select{|w| w.length > 2 && w.length < 20 }.map{|w| w.downcase }
        words.uniq!
        words
      end
      
      def train(item, cat)
        features = get_features(item)
        return if features.nil?
        features.each do |f|
          incf(f, cat)
        end
        incc(cat)
      end
    end
    
    require 'data_providers/memory_data_provider'
    require 'data_providers/sqlite3_data_provider'
  end
end