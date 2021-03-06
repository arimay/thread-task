require_relative 'lib/thread/task/version'

Gem::Specification.new do |spec|
  spec.name          = "thread-task"
  spec.version       = Thread::Task::VERSION
  spec.authors       = ["arimay"]
  spec.email         = ["arima.yasuhiro@gmail.com"]

  spec.summary       = %q{ Wrapper library for Thread class for easily describing parallel processing. }
  spec.description   = %q{ Yet another, a wrapper library of Thread class. Thread::Task, Thrad::Pool, Kernel#future }
  spec.homepage      = "https://github.com/arimay/thread-task/"
  spec.license       = "MIT"

  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "rake", "~> 12.0"
  spec.add_development_dependency "rspec", "~> 3.0"
end
