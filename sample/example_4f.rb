require  "thread/task/future"

results  =  []

tasks  =  (0..4).map do |ndx|
  future do
    wait  =  rand * 3
    sleep  wait
    results  <<  [wait, ndx]
  end
end

tasks.each(&:join)

pp results

