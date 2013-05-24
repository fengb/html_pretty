$:.push File.expand_path("../lib", __FILE__)
require "html_pretty/version"

Gem::Specification.new do |gem|
  gem.name    = 'html_pretty'
  gem.version = HtmlPretty::VERSION
  gem.summary = "Make HTML pretty."
  gem.description = "html_pretty is yet another HTML prettifier.  It purposefully does not do parsing or validation."

  gem.authors  = ['Benjamin Feng']
  gem.email    = 'benjamin.feng@gmail.com'
  gem.homepage = 'http://github.com/fengb/html_pretty'

  gem.add_development_dependency 'rspec',    ">= 2.0.0"
  gem.add_development_dependency 'cucumber', ">= 1.3.0"
  %w[htmlbeautifier nokogiri].each do |rival|
    gem.add_development_dependency rival
  end

  gem.files = Dir["{bin,lib}/**/*"] + %w{LICENSE Rakefile README.md}
  gem.executables = Dir["bin/**"].map { |f| File.basename(f) }
end
