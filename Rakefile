require "bundler/gem_tasks"

desc "The deploy task that GCore Main will be executing"
task :deploy do
  puts "Getting updates from Git..."
  branch = `git symbolic-ref -q HEAD | cut -d"/" -f 3`
  puts "Working on branch #{branch}"
  puts "Retrieving the latest and greatest source code..."
  system("git checkout -q #{branch}")
  system("git fetch")
  system("git pull origin #{branch}")
  system("bundle install")
  system("rake install")
end


