# frozen_string_literal: true

require 'jekyll'
require 'nokogiri'
require_relative 'jekyll-react-component/react_component'
require_relative 'jekyll-react-component/version'

REACT_COMPONENT_PAGES_ID = [] # rubocop:disable Style/MutableConstant
REACT_COMPONENT_REGEX = /\{% react_component .+ %\}(.|\n)*\{% endreact_component %\}/.freeze

Jekyll::Hooks.register [:pages, :posts], :pre_render do |page|
  REACT_COMPONENT_PAGES_ID << page.object_id if page.content.match?(REACT_COMPONENT_REGEX)
end

Jekyll::Hooks.register [:pages, :posts], :post_render do |page|
  if REACT_COMPONENT_PAGES_ID.include?(page.object_id)
    html = page.output
    doc = Nokogiri::HTML(html)
    head = doc.at_css('head')
    unless head.nil?
      head << <<~CODE
        <script async src="https://unpkg.com/es-module-shims@0.12.8/dist/es-module-shims.js"></script>
        <script type="importmap">
          {
            "imports": {
              "react": "https://esm.sh/react",
              "react-dom": "https://esm.sh/react-dom",
              "htm": "https://esm.sh/htm",
              "assets/": "/assets/"
            }
          }
        </script>
      CODE
    end

    REACT_COMPONENT_PAGES_ID.clear
    page.output = doc.to_html
  end
end
