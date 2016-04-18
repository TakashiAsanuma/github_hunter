require 'octokit'
require 'json'
require 'pp'
require 'net/http'
require 'uri'

class GithubHunter
  def initialize(language = nil, location = nil)
    @language = language
    @location = location
    @client = Octokit::Client.new(:access_token => ENV['GITHUB_API_TOKEN'])
  end

  # get total count result of search users 
  # @return [integer]
  def total_count
    users = @client.search_users("language:#{@language} location:#{@location}")
    users.total_count.to_i
  end

  # get login ids
  # Github Search API provides up to 1,000 results for each search
  # @param [total_count] integer
  # @return [array]
  def login_ids(total_count)
    login_ids = []
    total_count = total_count > 1000 ? 1000 : total_count
    pages = (total_count.to_f/100).ceil
    (1..pages).each do |page|
      users = @client.search_users("language:#{@language} location:#{@location}", {:page => page, :per_page => 100})
      users.items.each do |user|
        login_ids.push(user.login)
      end
    end
    login_ids
  end 

  # get user information
  # @param [login_id] string
  # @return [object]
  def user(login_id)
    @client.user login_id
  end
end

