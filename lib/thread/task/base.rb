require 'monitor'

class ::Thread

  class Task < ::BasicObject
    def initialize( *args, pool: nil, &block )
      raise  ::ArgumentError, "block required."    if block.nil?

      if  pool.nil?
        @thread  =  ::Thread.start( args ) do |args|
          ::Thread.current.report_on_exception  =  false
          block.call( *args )
        end

      elsif  pool.is_a? ::Thread::Pool
        @thread  =  ::Thread.start( args ) do |args|
          ::Thread.current.report_on_exception  =  false
          pool.acquire
          begin
            block.call( *args )
          ensure
            pool.release
          end
        end

      else
        raise  ::ArgumentError, "Nil or Thread::Pool object expected."

      end
    end

    def join
      @thread.join    rescue nil
      nil
    end

    def value
      @thread.value
    end

    def cancel
      @thread.kill
      nil
    end
  end

  class Pool
    attr_reader  :rest

    def initialize( size )
      @rest  =  size
      @monitor  =  Monitor.new
      @lock_cond  =  @monitor.new_cond
    end

    def acquire
      @monitor.synchronize do
        @lock_cond.wait_while{ @rest == 0 }
        @rest  -=  1
      end
    end

    def release
      @monitor.synchronize do
        @rest  +=  1
        @lock_cond.signal
      end
    end
  end

end

