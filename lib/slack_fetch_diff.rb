require 'active_support/core_ext/module/delegation'
require 'slack-ruby-client'
require 'slack_fetch_diff/version'
require 'slack_fetch_diff/cache'
require 'slack_fetch_diff/history'
require 'slack_fetch_diff/channel'
require 'slack_fetch_diff/user'

class SlackFetchDiff
  class Error < StandardError; end

  attr_reader :token, :cache_dir

  def initialize(token:, cache_dir:)
    @token = token
    @cache_dir = cache_dir
  end

  def channel
    @channel ||= Channel.new(client, cache)
  end
  delegate :channel_list, :reload_channel_list, :channel_info_by_id, :channel_info_by_name, to: :channel

  def history
    @history ||= History.new(client, cache)
  end
  delegate :fetch_messages, to: :history

  def user
    @user ||= User.new(client, cache)
  end
  delegate :bot_name_by, :user_name_by, to: :user

  private

  def cache
    @cache ||= Cache.new(cache_dir: (ENV['SLACK_FETCH_DIFF_CACHE_DIR'] || '/tmp/slack_fetch_diff_cache/'))
  end

  def client
    @client ||= ::Slack::Web::Client.new(token: token)
  end
end
