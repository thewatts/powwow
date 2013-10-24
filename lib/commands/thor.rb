require 'thor'
require './lib/ideabox'

module Ideabox

  class Thor < ::Thor

    no_commands {

      def url
        "http://localhost:9292"
      end

      def access_key
        "adb0ddafd901c4073dca3251b0dc1cdeb15bcdfe"
      end

      def api
        Ideabox::Client.new(url, access_key)
      end

      def display_idea(idea)
        "#{idea['id']} - #{idea['title']} - #{idea['description']}"
      end

    }

    desc "new",
      "create a new idea, ex => title :: description % tag, tag, tag"
    def new(*input)
      api.create(input.join(" "))
    end

    desc "list",
      "list out your ideas!"
    def list
      ideas = api.list["ideas"]
      ideas.each do |idea|
        puts display_idea(idea)
      end
    end

  end

end

