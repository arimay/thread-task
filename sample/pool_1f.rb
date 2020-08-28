require "thread/task/future"

pool  =  ::Thread::Pool.new( 3 )

tasks  =  (0...10).map do |i|
  future( i, pool: pool ) do |j|
    p ["-->", j]
    sleep(rand*2)
    p ["<--", j]
  end
end

tasks.each(&:join)

