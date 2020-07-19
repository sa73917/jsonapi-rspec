require 'spec_helper'

RSpec.describe JSONAPI::RSpec, '#have_jsonapi_object' do
  let(:doc) do
    {
      'jsonapi' => {
        'version' => '1.0'
      }
    }
  end

  context 'when providing no value' do
    it 'succeeds when jsonapi object is present' do
      expect(doc).to have_jsonapi_object
    end

    it 'fails when jsonapi object is absent' do
      expect({}).not_to have_jsonapi_object
    end
  end

  context 'when providing a value' do
    context 'with jsonapi indifferent hash enabled' do
      before(:all) { ::RSpec.configuration.jsonapi_indifferent_hash = true }
      after(:all) { ::RSpec.configuration.jsonapi_indifferent_hash = false }

      it 'succeeds when jsonapi object indifferent matches' do
        expect(doc).to have_jsonapi_object(version: '1.0')
      end
    end

    context 'without jsonapi indifferent hash enabled' do
      it 'succeeds when jsonapi object matches' do
        expect(doc).to have_jsonapi_object('version' => '1.0')
      end

      it 'fails when jsonapi object mismatches' do
        expect(doc).not_to have_jsonapi_object('version' => '2.0')
      end

      it 'fails when jsonapi object is absent' do
        expect({}).not_to have_jsonapi_object('version' => '1.0')
      end
    end
  end
end
