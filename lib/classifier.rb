$:.unshift(File.dirname(__FILE__))

require 'data_provider'

module Classifier
  class Base
    def init_data(data_provider)
      @provider = data_provider
    end
    
    def train(doc, category)
      @provider.train(doc, category)
    end
    
    def get_features(doc)
      @provider.get_features(doc)
    end
    
    def incc(cat)
      @provider.incc(cat)
    end

    def incf(f, cat)
      @provider.incf(f, cat)
    end

    def fcount(f, cat)
      @provider.fcount(f, cat)
    end

    def catcount(cat)
      @provider.catcount(cat)
    end

    def total_count
      @provider.total_count
    end

    def categories
      @provider.categories
    end
  end
  require 'classifier/fisher_classifier'
end

module Classifier
  VERSION = '1.0.0'
  
  @@data_provider = :sqlite
  def Classifier.instance
    @@classifier ||= Classifier::FisherClassifier.new(provider)
    @@classifier
  end
  
  def Classifier.provider=(provider)
    @@data_provider = provider
  end
  
  def Classifier.provider
    if @@data_provider == :sqlite
      return Classifier::DataProvider::Sqlite3DataProvider.new
    end
    return Classifier::DataProvider::MemoryDataProvider.new
  end
  
  def Classifier.train(doc, category)
    instance.train(doc, category)
  end
  
  def Classifier.classify(doc)
    instance.classify(doc)
  end
end

require 'server/fisher_spam_server'