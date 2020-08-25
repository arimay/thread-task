require "thread/task/future"

pool  =  ::Thread::Pool.new(3)

tasks  =  (0...10).map do |ndx|
  future(pool) do
    p ["-->", ndx]
    sleep( rand * 2 )
    p ["<--", ndx]
  end
end

tasks.each(&:join)

