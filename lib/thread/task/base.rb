require 'monitor'

class ::Thread

  class Task < ::BasicObject
    def initialize( pool = nil, &block )
      raise  ::ArgumentError, "block required."    if block.nil?

      if pool.nil?
        @thread  =  ::Thread.start do
          ::Thread.current.report_on_exception  =  false
          block.call
        end
      else
        @thread  =  ::Thread.start do
          ::Thread.current.report_on_exception  =  false
          pool.acquire
          begin
            block.call
          ensure
            pool.release
          end
        end
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

