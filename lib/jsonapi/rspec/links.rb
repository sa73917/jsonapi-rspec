module JSONAPI
  module RSpec
    module Links
      ::RSpec::Matchers.define :have_link do |link|
        match do |actual|
          actual = JSONAPI::RSpec.as_indifferent_hash(actual)
          return false unless actual.key?('links')

          link = JSONAPI::RSpec.as_indifferent_hash(link)
          actual['links'].key?(link) &&
            (!@val_set || actual['links'][link] == @val)
        end

        chain :with_value do |val|
          @val_set = true
          @val = JSONAPI::RSpec.as_indifferent_hash(val)
        end
      end

      ::RSpec::Matchers.define :have_links do |*links|
        match do |actual|
          actual = JSONAPI::RSpec.as_indifferent_hash(actual)
          return false unless actual.key?('links')

          links = JSONAPI::RSpec.as_indifferent_hash(links)
          links.all? { |link| actual['links'].key?(link) }
        end
      end
    end
  end
end
