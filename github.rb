require 'octokit'
require 'json'
require 'pp'
require 'net/http'
require 'uri'

class GithubHunter
  def initialize()
    @client = Octokit::Client.new(:access_token => ENV['GITHUB_API_TOKEN'])
  end

  def get_total_count
    users = @client.search_users('language:ruby location:Vietnam')
    return  users.total_count
  end

  def get_users(total_count)
    pages = total_count/100+1

    i = 0
    (1..pages).each do |page|
      puts page
      users = @client.search_users('language:ruby location:Vietnam', {:page => page, :per_page => 100})
      users.items.each do |user|
        #pp user.html_url
        puts i += 1
      end
    end
  end 
end

