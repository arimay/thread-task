
require "thread/task/future"

begin
  pool  =  ::Thread::Pool.new( 1 )
  task  =  future( pool: pool ) do
    sleep  1
    raise  "die now"
  end

  p :wait
  sleep  2

  p :join
  p task.join

  p :done

rescue => e
  p e.message

end

