require "thread/task/future"

RSpec.describe Thread::Pool do

  it "Task.new       time order 1" do
    pool  =  ::Thread::Pool.new(3)
    tasks  =  (0...10).map do |i|
      Thread::Task.new( i, pool: pool ) do |j|
        expect( i ).to be == j
        expect( pool.rest ).to be >= 0
        expect( pool.rest ).to be <= 3
        sleep( rand * 2 )
        time  =  Time.now
      end
    end
    time1  =  Time.now
    times  =  tasks.map(&:value)
    time2  =  Time.now
    times.each do |time|
      expect( time ).to be >= time1
      expect( time ).to be <= time2
    end
  end

  it "Kernel#future  time order 2" do
    pool  =  ::Thread::Pool.new(3)
    tasks  =  (0...10).map do |i|
      future( i, pool: pool ) do |j|
        expect( i ).to be == j
        expect( pool.rest ).to be >= 0
        expect( pool.rest ).to be <= 3
        sleep( rand * 2 )
        time  =  Time.now
      end
    end
    time1  =  Time.now
    times  =  tasks.map(&:value)
    time2  =  Time.now
    times.each do |time|
      expect( time ).to be >= time1
      expect( time ).to be <= time2
    end
  end

end
