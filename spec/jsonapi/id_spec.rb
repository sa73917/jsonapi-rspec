require 'spec_helper'

RSpec.describe JSONAPI::RSpec, '#have_id' do
  let(:doc) do
    {
      'id' => 'foo'
    }
  end

  context 'with jsonapi indifferent hash enabled' do
    before(:all) { ::RSpec.configuration.jsonapi_indifferent_hash = true }
    after(:all) { ::RSpec.configuration.jsonapi_indifferent_hash = false }

    it { expect(doc).to have_id(:foo) }
  end

  context 'without jsonapi indifferent hash enabled' do
    it { expect(doc).to have_id('foo') }
    it { expect(doc).not_to have_id('bar') }
  end

  context 'when id is absent' do
    it { expect({}).not_to have_id('foo') }
  end
end
