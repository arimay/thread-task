require "thread/task/future"

RSpec.describe Thread::Task do
  it ".new" do
    expect( ::Thread::Task.new do end ).not_to be nil
  end

  it "future" do
    expect( future do end ).not_to be nil
  end
end
