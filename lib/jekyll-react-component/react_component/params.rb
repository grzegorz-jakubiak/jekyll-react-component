# frozen_string_literal: true

require 'json'
require 'json-schema'
require 'active_support'
require 'active_support/core_ext/module'

class ReactComponent < Liquid::Block
  class Params
    COMPONENT_SCHEMA = JSON.parse(
      File.open(
        File.expand_path('../../../schemas/component.json', __dir__)
      ).read
    )
    private_constant :COMPONENT_SCHEMA

    delegate_missing_to :@params

    def initialize(params)
      JSON::Validator.validate!(COMPONENT_SCHEMA, params)
      @params = JSON.parse(params, symbolize_names: true)
    end
  end
end
