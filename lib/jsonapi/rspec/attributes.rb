module JSONAPI
  module RSpec
    module Attributes
      ::RSpec::Matchers.define :have_attribute do |attr|
        match do |actual|
          actual = JSONAPI::RSpec.as_indifferent_hash(actual)
          return false unless actual.key?('attributes')

          attr = JSONAPI::RSpec.as_indifferent_hash(attr)
          actual['attributes'].key?(attr) &&
            (!@val_set || actual['attributes'][attr] == @val)
        end

        chain :with_value do |val|
          @val_set = true
          @val = JSONAPI::RSpec.as_indifferent_hash(val)
        end
      end

      ::RSpec::Matchers.define :have_jsonapi_attributes do |*attrs|
        match do |actual|
          actual = JSONAPI::RSpec.as_indifferent_hash(actual)
          return false unless actual.key?('attributes')

          attrs = JSONAPI::RSpec.as_indifferent_hash(attrs)
          counted = (attrs.size == actual['attributes'].size) if @exactly
          (attrs - actual['attributes'].keys).empty? &&
            (counted == @exactly)
        end

        chain :exactly do
          @exactly = true
        end
      end
    end
  end
end
