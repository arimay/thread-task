
require "thread/task"

begin
  task  =  ::Thread::Task.new do
    sleep  1
    raise  "die now"
  end

  p :wait
  sleep  2

  p :value
  p task.value

  p :do_not_reach

rescue => e
  p e.message

end

