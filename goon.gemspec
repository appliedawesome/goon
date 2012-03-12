require File.join([File.dirname(__FILE__), 'lib', 'goon', 'version.rb'])
spec = Gem::Specification.new do |s|
  s.name = 'goon'
  s.version = Goon::VERSION
  s.author = 'Dennis Walters'
  s.email = 'pooster@gmail.com'
  s.homepage = 'https://github.com/ess/goon'
  s.platform = Gem::Platform::RUBY
  s.summary = 'A loyal lackey'
  s.description = <<-EOF
  Goon is a minion that pulls off Heists
  EOF
  s.files = Dir.glob('lib/**/*.rb') + %w(README.md)
  s.require_paths << 'lib'
  s.rdoc_options << '--title' << 'goon' << '--main' << 'README.md' << '-ri'
  s.add_development_dependency('rake', '~> 0.9.2')
  s.add_development_dependency('rdoc', '~> 3.8')
  s.add_development_dependency('rspec', '~> 2.8.0')
  s.add_development_dependency('coco', '~> 0.6')
  s.add_development_dependency('mocha', '~> 0.10.5')
end
