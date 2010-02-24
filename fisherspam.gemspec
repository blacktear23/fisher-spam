require 'lib/classifier'

Gem::Specification.new do |s|
  s.name     = "fisherspam"
  s.version  = Classifier::VERSION
  s.date     = "2010-2-22"
  s.summary  = "Fisher Classifier"
  s.email    = "rain@joyent.com"
  s.homepage = "http://www.joyent.com.cn"
  s.description = "Use fisher classify method to indentify whether a document is a spam."
  s.authors  = ["Rain Li"]

  s.has_rdoc = true
  s.rdoc_options = ["--main", "README"]
  s.extra_rdoc_files = ["README"]

  s.files = %w[
    README
    fisherspam.gemspec
    Rakefile
    lib/classifier.rb
    lib/data_provider.rb
    lib/classifier/fisher_classifier.rb
    lib/data_providers/memory_data_provider.rb
    lib/data_providers/sqlite3_data_provider.rb
    lib/server/fisher_spam_server.rb
    lib/views/classify.erb
    lib/views/index.erb
    lib/views/train.erb
    spec/classifier_spec.rb
    spec/fisher_classifier_spec.rb
    spec/server_spec.rb
    spec/sqlite3_data_provider_spec.rb
    spec/spec_helper.rb
    db/README
    db/classifier.db
  ]
  s.add_dependency 'sqlite3-ruby', '>= 1.2.5'
  s.add_dependency 'sinatra', '>= 0.9.4'
  s.add_dependency 'rspec', '>= 1.3.0'
end