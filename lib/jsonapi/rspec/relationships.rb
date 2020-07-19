module JSONAPI
  module RSpec
    module Relationships
      ::RSpec::Matchers.define :have_relationship do |rel|
        match do |actual|
          actual = JSONAPI::RSpec.as_indifferent_hash(actual)
          return false unless actual.key?('relationships')

          rel = JSONAPI::RSpec.as_indifferent_hash(rel)
          actual['relationships'].key?(rel) &&
            (!@data_set || actual['relationships'][rel]['data'] == @data_val)
        end

        chain :with_data do |val|
          @data_set = true
          @data_val = JSONAPI::RSpec.as_indifferent_hash(val)
        end

        failure_message do |actual|
          if !(actual['relationships'] || {}).key?(rel)
            "expected #{actual} to have relationship #{rel}"
          else
            "expected #{actual['relationships'][rel]} " \
              "to have data #{@data_val}"
          end
        end
      end

      ::RSpec::Matchers.define :have_relationships do |*rels|
        match do |actual|
          actual = JSONAPI::RSpec.as_indifferent_hash(actual)
          return false unless actual.key?('relationships')

          rels = JSONAPI::RSpec.as_indifferent_hash(rels)
          rels.all? { |rel| actual['relationships'].key?(rel) }
        end
      end
    end
  end
end
