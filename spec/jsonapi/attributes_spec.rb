require 'spec_helper'

RSpec.describe JSONAPI::RSpec do
  let(:doc) do
    {
      'attributes' => {
        'one' => 1,
        'two' => 2,
        'four' => 3
      }
    }
  end

  describe '#have_attribute' do
    context 'with jsonapi indifferent hash enabled' do
      before(:all) { ::RSpec.configuration.jsonapi_indifferent_hash = true }
      after(:all) { ::RSpec.configuration.jsonapi_indifferent_hash = false }

      it { expect(doc).to have_attribute(:one) }
    end

    context 'without jsonapi indifferent hash enabled' do
      it { expect(doc).to have_attribute('one') }
      it { expect(doc).not_to have_attribute('five') }
    end
  end

  describe '#have_jsonapi_attributes' do
    context 'with jsonapi indifferent hash enabled' do
      before(:all) { ::RSpec.configuration.jsonapi_indifferent_hash = true }
      after(:all) { ::RSpec.configuration.jsonapi_indifferent_hash = false }

      it { expect(doc).to have_jsonapi_attributes(:one, :two) }
    end

    context 'without jsonapi indifferent hash enabled' do
      it { expect(doc).to have_jsonapi_attributes('one', 'two') }
      it { expect(doc).not_to have_jsonapi_attributes('two', 'five') }
      it { expect(doc).to have_jsonapi_attributes('one', 'two', 'four').exactly }
      it { expect(doc).not_to have_jsonapi_attributes('one').exactly }
    end
  end
end
