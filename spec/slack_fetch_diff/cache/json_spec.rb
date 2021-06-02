require './spec/spec_helper'

RSpec.describe SlackFetchDiff::Cache::Json do
  let(:cache_dir) { './spec/fixture/cache/' }
  let(:key) { Faker::Lorem.characters(number: 10) }
  let(:set_value) { Faker::Lorem.character }

  it 'set value is equal to get value' do
    cache = SlackFetchDiff::Cache::Json.new(cache_dir: cache_dir)
    cache.set(key, set_value)
    get_value = cache.get(key)

    expect(get_value).to eq set_value
  end
end
