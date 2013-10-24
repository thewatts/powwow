require 'test_helper'

class ClientTest < MiniTest::Test

  attr_reader :client, :valid_key

  def setup
    @client = Powwow::Client.new
    @valid_key = create_key
  end

  def create_key
    Digest::SHA1.hexdigest(secret)
  end

  def secret
   "Make everything as simple as possible, but not simpler. 1234abcd"
  end

  def test_it_exists
    assert Powwow::Client
  end

  def test_it_creates_connection
    url = "http://google.com"
    client = Powwow::Client.new(url)
    assert_kind_of Faraday::Connection, client.conn
  end

  def test_it_converts_input_to_idea_data
    input = "go swimming :: in the vast vast ocean % tan, swim, beach"
    data = {
      :idea => {
        "title" => "go swimming",
        "description" => "in the vast vast ocean",
        "tags" => "tan, swim, beach"
      }
    }
    assert_equal data, client.parse_raw_idea(input)
  end

  def test_it_creates_a_new_idea
    input = "go swimming :: in the vast vast ocean % tan, swim, beach"
    response = "Thanks, Nathaniel, for creating 'go swimming' !!"
    url = "http://localhost:9292"
    client = Powwow::Client.new(url, valid_key)
    assert_equal response, client.create(input)
  end

  def test_it_gets_users_ideas
    response = "hello"
    url = "http://localhost:9292"
    client = Powwow::Client.new(url, valid_key)
    assert_kind_of Array, client.list["ideas"]
  end

end
