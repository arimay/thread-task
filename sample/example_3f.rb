require  "thread/task/future"

tasks  =  (0..4).map do |ndx|
  future do
    wait  =  rand * 3
    sleep  wait
    [wait, ndx]
  end
end

results  =  tasks.map(&:value)

pp results

