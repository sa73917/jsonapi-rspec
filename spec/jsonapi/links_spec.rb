require 'spec_helper'

RSpec.describe JSONAPI::RSpec do
  let(:doc) do
    {
      'links' => {
        'self' => 'self_link',
        'related' => 'related_link'
      }
    }
  end

  context '#have_link' do
    context 'with jsonapi indifferent hash enabled' do
      before(:all) { ::RSpec.configuration.jsonapi_indifferent_hash = true }
      after(:all) { ::RSpec.configuration.jsonapi_indifferent_hash = false }

      it { expect(doc).to have_link(:self) }
      it { expect(doc).to have_link(:self).with_value(:self_link) }
    end

    it { expect(doc).to have_link('self') }
    it { expect(doc).to have_link('self').with_value('self_link') }
    it { expect(doc).not_to have_link('self').with_value('any_link') }
    it { expect(doc).not_to have_link('any') }
  end

  context '#have_links' do
    context 'with jsonapi indifferent hash enabled' do
      before(:all) { ::RSpec.configuration.jsonapi_indifferent_hash = true }
      after(:all) { ::RSpec.configuration.jsonapi_indifferent_hash = false }

      it { expect(doc).to have_links(:self, :related) }
    end

    it { expect(doc).to have_links('self', 'related') }
    it { expect(doc).not_to have_links('self', 'other') }
  end
end
