require 'lita'
module Lita
  module Handlers
    class Tinysong < Handler

      route(/(groove)( me)? (.*)/i, :groove, command: true, help: { "groove (me) SONG" => "Returns a Tinysong url for SONG" })

      def self.default_config(config)
        config.api_key = nil
      end

      def groove(response)
        unless Lita.config.handlers.tinysong.api_key
          response.reply "Tinysong API key required"
          return
        end

        query = response.matches[0][2]
        result = http.get("http://tinysong.com/a/#{query}", format: 'json', key: Lita.config.handlers.tinysong.api_key).body

        if result == "[]" 
          response.reply "I couldn't find any results for '#{query}'!"
        else
          response.reply result
        end
      end

    end
    Lita.register_handler(Tinysong)
  end
end
    
