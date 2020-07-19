module JSONAPI
  module RSpec
    module Type
      ::RSpec::Matchers.define :have_type do |expected|
        match do |actual|
          actual = JSONAPI::RSpec.as_indifferent_hash(actual)
          return false unless actual.key?('type')

          expected = JSONAPI::RSpec.as_indifferent_hash(expected)
          actual['type'] == expected
        end
      end
    end
  end
end
