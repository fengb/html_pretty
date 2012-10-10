lib = File.expand_path('../lib/', __FILE__)
$:.unshift lib unless $:.include?(lib)

require 'html_pretty'

Gem::Specification.new do |gem|
  gem.name    = 'html_pretty'
  gem.version = HtmlPretty::VERSION
  gem.date    = Date.today.to_s

  gem.summary = "Make HTML pretty."
  gem.description = "html_pretty is yet another HTML prettifier.  It purposefully does not do parsing or validation."

  gem.authors  = ['Benjamin Feng']
  gem.email    = 'benjamin.feng@gmail.com'
  gem.homepage = 'http://github.com/fengb/html_pretty'

  gem.add_development_dependency('rspec', [">= 2.0.0"])

  gem.files = Dir["lib/**/*"] + %w{LICENSE README.md}
end
