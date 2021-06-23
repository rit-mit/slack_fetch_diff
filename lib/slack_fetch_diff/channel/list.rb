require_relative 'base'

class SlackFetchDiff
  class Channel
    class List < Base
      KVS_KEY_PREFIX = 'CHANNEL_LIST'.freeze

      def channel_list
        channel_list = cache.get(cache_key)

        if channel_list.nil?
          channel_list = fetch_from_api
          cache.set(cache_key, channel_list)
        end
        channel_list
      end

      def reload_channel_list
        channel_list = fetch_from_api
        cache.set(cache_key, channel_list)

        channel_list
      end

      private

      def cache_key
        "#{KVS_KEY_PREFIX}-#{Digest::MD5.hexdigest(client.token)}"
      end

      def fetch_from_api
        response = client.conversations_list(exclude_archived: true)
        return [] unless valid_response? response

        response['channels'].each_with_object({}) do |channel, result|
          result[channel['name']] = channel['id']
        end
      end

      def valid_response?(response)
        return false if response.nil?
        return false if response['channels']&.count&.zero?

        true
      end
    end
  end
end
