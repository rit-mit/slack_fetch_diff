class SlackFetchDiff
  class Channel
    class Base
      attr_reader :client, :cache

      def initialize(client, cache)
        @client = client
        @cache = cache
      end
    end
  end
end
