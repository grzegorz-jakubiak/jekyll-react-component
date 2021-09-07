# frozen_string_literal: true

require 'active_support'
require 'active_support/core_ext/string'
require 'jekyll'
require 'json'
require_relative 'react_component/params'

class ReactComponent < Liquid::Block
  def initialize(tag, params, tokens)
    parse_params(params)
    super
  end

  def render(context)
    @code = super

    <<~CODE
      <div id="#{@id}"></div>
      <script type="module">
        import React from 'react';
        import ReactDOM from 'react-dom';
        import htm from 'htm';
        const html = htm.bind(React.createElement);
        #{@code}

        ReactDOM.render(html`<${#{@name}} #{pass_props} />`, document.getElementById('#{@id}'));
      </script>
    CODE
  end

  private

  def parse_params(params)
    params = Params.new(params)
    @name = params[:name]
    @id = params.fetch(:id, @name.underscore.dasherize)
    @props = params.fetch(:props, nil)
  end

  def pass_props
    if @props.nil?
      ''
    else
      "...${#{@props.to_json}}"
    end
  end
end

Liquid::Template.register_tag('react_component', ReactComponent)
