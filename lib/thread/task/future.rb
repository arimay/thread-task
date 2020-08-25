require "thread/task/version"
require "thread/task/base"

module ::Kernel
  def future( pool = nil, &block )
    ::Thread::Task.new( pool, &block )
  end
end

