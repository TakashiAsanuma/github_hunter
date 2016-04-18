require 'thread'
require 'drb/drb'
require './lib/github_hunter.rb'

github_hunter = GithubHunter.new()

q = DRbObject.new_with_uri("druby://localhost:12345")

loop{|i| 
  login_id = q.pop
  puts github_hunter.user(login_id).name
}
