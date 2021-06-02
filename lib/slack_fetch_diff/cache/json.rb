require 'digest/md5'
require 'json'
require 'fileutils'
require 'pathname'

class SlackFetchDiff
  class Cache
    # http://lethe2211.hatenablog.com/entry/2014/07/23/161155
    class Json
      attr_reader :cache_dir

      PREFIX = 'cache_'.freeze
      POSTFIX = '.json'.freeze

      def initialize(cache_dir:)
        @cache_dir = cache_dir

        FileUtils.mkdir_p(@cache_dir)
      end

      def get(key)
        cache_file = cache_file_of key

        return nil unless File.exist? cache_file

        json = File.read(cache_file_of(key))
        JSON.parse(json)
      end

      def set(key, value)
        File.open(cache_file_of(key), 'w') do |io|
          JSON.dump(value, io)
        end
      end
      alias save set

      private

      def cache_file_of(key)
        cache_filename = "#{PREFIX}#{key}#{POSTFIX}"
        Pathname(cache_dir).join(cache_filename)
      end
    end
  end
end
