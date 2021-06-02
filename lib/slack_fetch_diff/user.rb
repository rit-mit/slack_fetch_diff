require 'digest/md5'

class SlackFetchDiff
  class User
    KVS_KEY_PREFIX_USER_NAME = 'USER_NAME_'.freeze

    attr_reader :client, :cache

    def initialize(client, cache)
      @client = client
      @cache = cache
    end

    def user_name_by(user_id, is_bot: false)
      return '' if user_id.nil? || user_id == ''

      kvs_key = "#{KVS_KEY_PREFIX_USER_NAME}-#{user_id}-#{Digest::MD5.hexdigest(client.token)}"
      user_name = cache.get(kvs_key)

      if user_name.nil?
        user_name = get_user_name_from_api(user_id, is_bot: is_bot)
        cache.set(kvs_key, user_name)
      end
      user_name
    end

    def bot_name_by(user_id)
      user_name_by(user_id, is_bot: true)
    end

    private

    def get_user_name_from_api(user_id, is_bot: false)
      if is_bot
        response = client.bots_info(bot: user_id)
        response.bot.name
      else
        response = client.users_info(user: user_id)
        response.user.name
      end
    end
  end
end
