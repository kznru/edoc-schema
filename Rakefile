# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

Dir[[Dir.pwd, 'tasks', '*.rake'].join('/')].each { |f| load f }
Dir[[Dir.pwd, 'lib', 'tasks', '*.rake'].join('/')].each { |f| load f }
