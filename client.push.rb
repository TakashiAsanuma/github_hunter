require 'thread'
require 'drb/drb'
require './lib/github_hunter.rb'

language = ARGV[0]
location = ARGV[1]

github_hunter = GithubHunter.new(language, location)
total_count = github_hunter.total_count
login_ids = github_hunter.login_ids(total_count)

q = DRbObject.new_with_uri("druby://localhost:12345") 

login_ids.each do |login_id|
  q.push login_id
end
