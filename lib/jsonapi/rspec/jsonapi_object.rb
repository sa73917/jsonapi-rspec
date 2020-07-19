module JSONAPI
  module RSpec
    module JsonapiObject
      ::RSpec::Matchers.define :have_jsonapi_object do |val|
        match do |actual|
          actual = JSONAPI::RSpec.as_indifferent_hash(actual)
          return false unless actual.key?('jsonapi')

          val = JSONAPI::RSpec.as_indifferent_hash(val)
          (!val || actual['jsonapi'] == val)
        end
      end
    end
  end
end
