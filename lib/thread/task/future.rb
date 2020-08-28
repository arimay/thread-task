require "thread/task/version"
require "thread/task/base"

module ::Kernel
  def future( *args, pool: nil, &block )
    ::Thread::Task.new( *args, pool: pool, &block )
  end
end

