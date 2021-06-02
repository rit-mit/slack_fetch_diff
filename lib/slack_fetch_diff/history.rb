require_relative 'history/parameter'

class SlackFetchDiff
  class History
    class Message < OpenStruct; end

    attr_reader :client, :cache

    def initialize(client, cache)
      @client = client
      @cache = cache
    end

    def fetch_messages(channel_id)
      params_for_fetch = parameter.generate_parameter(channel_id)

      fetch_messages_from_api(params_for_fetch) do |history|
        if history['messages']&.count&.positive?
          parameter.save_latest(channel_id, history['latest'])
        end
      end
    end

    private

    def parameter
      @parameter ||= Parameter.new(cache)
    end

    def fetch_messages_from_api(params)
      history_message = client.conversations_history(params)
      return if history_message.nil?

      yield(history_message)

      history_message['messages'].map do |message|
        # NOTE: APIからのレスポンスにはchannel_idが付いてないので、付けておく
        message['channel_id'] = params[:channel]
        Message.new(message)
      end
    end
  end
end
