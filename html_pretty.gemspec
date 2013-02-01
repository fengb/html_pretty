require File.expand_path('../lib/html_pretty/version', __FILE__)

Gem::Specification.new do |gem|
  gem.name    = 'html_pretty'
  gem.version = HtmlPretty::VERSION
  gem.date    = Date.today.to_s

  gem.summary = "Make HTML pretty."
  gem.description = "html_pretty is yet another HTML prettifier.  It purposefully does not do parsing or validation."

  gem.authors  = ['Benjamin Feng']
  gem.email    = 'benjamin.feng@gmail.com'
  gem.homepage = 'http://github.com/fengb/html_pretty'

  gem.add_development_dependency 'rspec', ">= 2.0.0"

  gem.files = Dir["{bin,lib}/**/*"] + %w{LICENSE Rakefile README.md}
  gem.executables = Dir["bin/**"].map { |f| File.basename(f) }
end
