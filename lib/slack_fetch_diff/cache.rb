require_relative 'cache/json'

class SlackFetchDiff
  class Cache
    attr_reader :cache_dir

    def initialize(cache_dir:)
      @cache_dir = cache_dir
    end

    def get(key)
      cache.get(key)
    end

    def set(key, value)
      cache.save(key, value)
    end

    private

    def cache
      @cache ||= Json.new(cache_dir: cache_dir)
    end
  end
end
