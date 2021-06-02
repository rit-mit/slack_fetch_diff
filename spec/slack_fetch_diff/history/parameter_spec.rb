require './spec/spec_helper'

RSpec.describe SlackFetchDiff::History::Parameter do
  include_context 'cache'

  let(:channel_id) { Faker::Lorem.characters }
  let(:latest) { Time.now.to_i }

  let(:model) { described_class.new(cache) }

  before do
    allow(model).to receive(:generate_latest).and_return(latest)
  end

  describe '#generate_parameter' do
    shared_examples_for 'return parameter' do
      it 'should return expected hash' do
        expected = {
          channel:   channel_id,
          latest:    latest,
          oldest:    oldest,
          count:     5,
          inclusive: true,
          unreads:   true
        }
        is_expected.to eq expected
      end
    end

    subject { model.generate_parameter(channel_id, resume: resume) }

    context 'resume is true' do
      let(:resume) { true }
      let(:oldest) { Faker::Number.decimal }

      before do
        expect(model).to receive(:get_oldest).and_return(oldest)
      end

      it_behaves_like 'return parameter'
    end

    context 'resume is false' do
      let(:resume) { false }
      let(:oldest) { '' }

      before do
        expect(model).not_to receive(:get_oldest)
      end

      it_behaves_like 'return parameter'
    end
  end
end
