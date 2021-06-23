require './spec/spec_helper'

RSpec.describe ::SlackFetchDiff::Channel::Info do
  include_context 'client'
  include_context 'cache'

  let(:model) { described_class.new(client, cache) }

  shared_examples_for 'return channel info' do
    let(:expected_result) { %w[general C012AB3CD] }

    it 'should return channel list' do
      is_expected.to eq expected_result
    end
  end

  describe '#channel_info_by_id', vcr: { cassette_name: 'conversation_info' } do
    subject { model.channel_info_by_id(channel_id) }

    let(:channel_id) { 'C012AB3CD' }

    it_behaves_like 'return channel info'
  end

  describe '#channel_info_by_name', vcr: { cassette_name: 'conversation_info' } do
    subject { model.channel_info_by_name(channel_name) }

    context 'given valid channel name starts with "#"' do
      let(:channel_name) { '#general' }

      it_behaves_like 'return channel info'
    end

    context 'given valid channel name not starts with "#"' do
      let(:channel_name) { 'general' }

      it_behaves_like 'return channel info'
    end
  end

  describe '#reload_channel_info', vcr: { cassette_name: 'conversation_info' } do
    let(:channel) { 'C012AB3CD' }

    before do
      expect(cache).not_to receive(:get)
    end

    subject { model.reload_channel_info(channel) }

    it_behaves_like 'return channel info'
  end
end
