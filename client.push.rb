require 'thread'
require 'drb/drb'

q = DRbObject.new_with_uri("druby://localhost:12345") 
100.times{|i| q.push "we add #{i}" }
