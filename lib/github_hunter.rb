require 'octokit'
require 'json'
require 'pp'
require 'net/http'
require 'uri'

class GithubHunter
  def initialize()
    @client = Octokit::Client.new(:access_token => ENV['GITHUB_API_TOKEN'])
  end

  # get total count result of search users 
  # @return [integer]
  def total_count
    users = @client.search_users('language:ruby location:Vietnam')
    return  users.total_count
  end

  # get login ids
  # @param [total_count] integer
  # @return [array]
  def login_ids(total_count)
    login_ids = []
    pages = total_count/100+1
    (1..pages).each do |page|
      users = @client.search_users('language:ruby location:Vietnam', {:page => page, :per_page => 100})
      users.items.each do |user|
        login_ids.push(user.login)
      end
    end
    return login_ids
  end 

  # get user information
  # @return [object]
  def user(login_id)
    user = @client.user login_id
    return user
  end
end

