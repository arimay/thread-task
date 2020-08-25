require "thread/task"

task  =  ::Thread::Task.new do
  sleep  2
  Time.now
end
p task.value

