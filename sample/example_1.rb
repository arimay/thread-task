
thread  =  ::Thread.new do
  sleep  2
  Time.now
end
p thread.value

