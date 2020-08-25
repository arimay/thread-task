require "thread/task/future"

task  =  future do
  sleep  2
  Time.now
end
p task.value

