require_relative 'lib/slack_fetch_diff/version'

Gem::Specification.new do |spec|
  spec.name          = 'slack_fetch_diff'
  spec.version       = SlackFetchDiff::VERSION
  spec.authors       = ['dnond']
  spec.email         = ['tarosuk@gmail.com']

  spec.summary       = 'fetch slack channel messages'
  spec.description   = 'fetch slack channel messages'
  spec.homepage      = 'https://github.com/rit-mit/slack_fetch_diff'
  spec.required_ruby_version = Gem::Requirement.new('>= 2.7.2')

  spec.metadata['homepage_uri'] = spec.homepage

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.require_paths = ['lib']

  spec.add_development_dependency 'activesupport'
  spec.add_development_dependency 'slack-ruby-client'
end
