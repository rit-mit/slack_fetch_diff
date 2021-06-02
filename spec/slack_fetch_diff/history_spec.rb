require './spec/spec_helper'

RSpec.describe SlackFetchDiff::History do
  include_context 'client'
  include_context 'cache'

  let(:model) { described_class.new(client, cache) }

  describe '#fetch_messages', vcr: { cassette_name: 'conversation_history' } do
    let(:channel_id) { Faker::Lorem.characters }

    subject { model.fetch_messages(channel_id) }

    it 'should return conversation history of the channel' do
      results = subject

      expect(results.count).to eq 2

      expected = [
        OpenStruct.new(
          'type' => 'message',
          'user' => 'U012AB3CDE',
          'text' => 'I find you punny and would like to smell your nose letter',
          'ts' => '1512085950.000216',
          'channel_id' => channel_id
        ),
        OpenStruct.new(
          'type' => 'message',
          'user' => 'U061F7AUR',
          'text' => 'What, you want to smell my shoes better?',
          'ts' => '1512104434.000490',
          'channel_id' => channel_id
        )
      ]
      expect(results).to match_array expected
    end
  end
end
