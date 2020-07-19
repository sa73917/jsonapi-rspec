require 'spec_helper'

RSpec.describe JSONAPI::RSpec, '#have_type' do
  let(:doc) do
    {
      'type' => 'foo'
    }
  end

  context 'with jsonapi indifferent hash enabled' do
    before(:all) { ::RSpec.configuration.jsonapi_indifferent_hash = true }
    after(:all) { ::RSpec.configuration.jsonapi_indifferent_hash = false }

    it { expect(doc).to have_type(:foo) }
  end

  context 'without jsonapi indifferent hash enabled' do
    it { expect(doc).to have_type('foo') }
    it { expect(doc).not_to have_type('bar') }
  end

  it 'when type is absent' do
    expect({}).not_to have_type('foo')
  end
end
