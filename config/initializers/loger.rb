module Selenium
  module WebDriver
    class Options

      #
      # Returns the available logs for this webDriver instance
      #
      def available_log_types
        @bridge.getAvailableLogTypes
      end

      #
      # Returns the requested log
      #
      # @param type [String] The required log type
      #
      # @return [Array] An array of log entries
      #
      def self.get_log(type)
        @bridge.get_logs(type)
      end

    end
  end
end
