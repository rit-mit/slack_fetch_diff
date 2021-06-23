require_relative 'base'

class SlackFetchDiff
  class Channel
    class Info < Base
      KVS_KEY_PREFIX = 'CHANNEL_INFO_'.freeze

      def channel_info_by_id(channel_id)
        fetch(channel_id)
      end

      def channel_info_by_name(channel_name)
        channel_name = "##{channel_name}" unless channel_name[0] == '#'
        fetch(channel_name)
      end

      def reload_channel_info(channel)
        info = fetch_from_api(channel)
        cache.set(cache_key, info)

        info
      end

      private

      def cache_key
        "#{KVS_KEY_PREFIX}-#{Digest::MD5.hexdigest(client.token)}"
      end

      def fetch(channel)
        info = cache.get(cache_key)

        if info.nil?
          info = fetch_from_api(channel)
          cache.set(cache_key, info)
        end

        info
      end

      def fetch_from_api(channel)
        response = client.conversations_info(channel: channel)

        info = response.fetch('channel', nil)
        return if info.nil?

        [info['name'], info['id']]
      end
    end
  end
end
