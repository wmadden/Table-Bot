RUBY = "/usr/bin/env ruby"
RUBY_OPTS = "-I lib"
RUBY_EXEC = "#{RUBY} #{RUBY_OPTS}"

desc "Runs the application"
task :run do
  sh("#{RUBY_EXEC} ./bin/table_bot")
end

desc "Runs RSpec"
task :test do
  sh("bundle exec rspec -I lib spec")
end
