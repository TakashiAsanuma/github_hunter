require 'thread'
require 'drb/drb'

q = DRbObject.new_with_uri("druby://localhost:12345")
loop{|i| puts q.pop}
