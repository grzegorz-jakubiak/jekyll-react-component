# frozen_string_literal: true

require_relative 'lib/jekyll-react-component/version'

Gem::Specification.new do |spec|
  spec.name          = 'jekyll-react-component'
  spec.version       = Jekyll::ReactComponent::VERSION
  spec.authors       = ['Grzegorz Jakubiak']
  spec.email         = ['grzegorz.jakubiak@outlook.com']

  spec.summary       = 'Simple gem adding `react_component` tag to jekyll'
  spec.homepage      = 'https://github.com/grzegorz-jakubiak/jekyll-react-component'
  spec.license       = 'MIT'
  spec.required_ruby_version = '>= 2.6.0'

  spec.metadata['homepage_uri'] = spec.homepage
  spec.metadata['source_code_uri'] = 'https://github.com/grzegorz-jakubiak/jekyll-react-component'
  spec.metadata['changelog_uri'] = 'https://github.com/grzegorz-jakubiak/jekyll-react-component/blob/master/CHANGELOG.md'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{\A(?:test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'activesupport', '~> 6.1', '>= 6.1.4.1'
  spec.add_dependency 'jekyll'
  spec.add_dependency 'json-schema', '~> 2.8', '>= 2.8.1'
  spec.add_dependency 'nokogiri', '~> 1.12', '>= 1.12.3'
end
