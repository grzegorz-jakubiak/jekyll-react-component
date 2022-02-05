# frozen_string_literal: true

require 'jekyll'
require 'nokogiri'
require_relative 'jekyll-react-component/react_component'
require_relative 'jekyll-react-component/version'

$react_component_pages_id = []

Jekyll::Hooks.register [:pages, :posts], :pre_render do |page|
  if page.content.match?(/\{% react_component .+ %\}(.|\n)*\{% endreact_component %\}/)
    $react_component_pages_id << page.object_id
  end
end

Jekyll::Hooks.register [:pages, :posts], :post_render do |page|
  if $react_component_pages_id.include?(page.object_id)
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
    
    $react_component_pages_id.clear
    page.output = doc.to_html
  end
end
