require './spec/spec_helper'

RSpec.describe ::SlackFetchDiff::Channel::List do
  include_context 'client'
  include_context 'cache'

  let(:model) { described_class.new(client, cache) }

  shared_examples_for 'return channel list' do
    let(:expected_result) { [%w[general C012AB3CD], %w[random C061EG9T2]] }

    it 'should return channel list' do
      is_expected.to match_array expected_result
    end
  end

  describe '#channel_list', vcr: { cassette_name: 'conversation_list' } do
    subject { model.channel_list }

    it_behaves_like 'return channel list'
  end

  describe '#reload_channel_list', vcr: { cassette_name: 'conversation_list' } do
    before do
      expect(cache).not_to receive(:get)
    end

    subject { model.reload_channel_list }

    it_behaves_like 'return channel list'
  end
end
