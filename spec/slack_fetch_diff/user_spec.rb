require './spec/spec_helper'

RSpec.describe SlackFetchDiff::User do
  include_context 'client'
  include_context 'cache'

  let(:user_id) { Faker::Lorem.characters }
  let(:model) { described_class.new(client, cache) }

  describe '#user_name_by', vcr: { cassette_name: 'users_info' } do
    subject { model.user_name_by(user_id) }

    it 'should return expected user name' do
      is_expected.to eq 'spengler'
    end
  end

  describe '#bot_name_by', vcr: { cassette_name: 'bots_info' } do
    subject { model.bot_name_by(user_id) }

    it 'should return expected bot name' do
      is_expected.to eq 'beforebot'
    end
  end
end
