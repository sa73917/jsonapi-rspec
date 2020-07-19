module JSONAPI
  module RSpec
    module Id
      ::RSpec::Matchers.define :have_id do |expected|
        match do |actual|
          actual = JSONAPI::RSpec.as_indifferent_hash(actual)
          return false unless actual.key?('id')

          expected = JSONAPI::RSpec.as_indifferent_hash(expected)
          actual['id'] == expected
        end
      end
    end
  end
end
