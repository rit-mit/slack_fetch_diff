require 'digest/md5'
require_relative 'channel/info'
require_relative 'channel/list'

class SlackFetchDiff
  class Channel
    attr_reader :client, :cache

    def initialize(client, cache)
      @client = client
      @cache = cache
    end

    def info
      @info ||= Info.new(client, cache)
    end
    delegate :channel_info_by_id, :channel_info_by_name, to: :info

    def list
      @list || List.new(client, cache)
    end
    delegate :channel_list, :reload_channel_list, to: :list
  end
end
