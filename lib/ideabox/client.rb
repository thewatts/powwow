require 'faraday'
require 'pry'
require 'json'

module Ideabox

  class Client

    attr_reader :conn, :url, :user_key

    def initialize(url = default_url, user_key = "")
      @url      = url
      @conn     = create_connection(url)
      @user_key = user_key
    end

    def default_url
      "http://localhost:9292"
    end

    def create_connection(url)
      Faraday.new(:url => url) do |faraday|
        faraday.request  :url_encoded             # form-encode POST params
        faraday.response :logger                  # log requests to STDOUT
        faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
      end
    end

    def create(input)
      data     = parse_raw_idea(input).merge({:access_key => user_key})
      response = post_idea(data)
      message  = JSON.parse(response.body)
      if message["success"]
        message["success"]
      elsif message["error"]
        message["error"]
      end
    end

    def post_idea(data)
      conn.post do |req|
        req.url(url + '/api/v1/ideas/new')
        req.headers['Content-Type'] = 'application/json'
        req.body = data.to_json.to_s
      end
    end

    def parse_raw_idea(input)
      title, leftovers  = input.split(" :: ")
      description, tags = leftovers.split(" % ")
      {
        :idea => {
          "title"       => title.to_s.strip,
          "description" => description.to_s.strip,
          "tags"        => tags
        }
      }
    end

    def list
      response = get_ideas.body
      ideas = JSON.parse(response)
    end

    def get_ideas
      conn.get do |req|
        req.url(url + '/api/v1/ideas')
        req.params[:access_key] = user_key
      end
    end

  end

end
