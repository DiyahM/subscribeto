#!/usr/bin/env rake
# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Subscribeto::Application.load_tasks

if defined? RSpec # otherwise fails on non-live environments  
  task(:spec).clear  
  desc "Run all specs/features in spec directory"  
  RSpec::Core::RakeTask.new(:spec => 'db:test:prepare') do |t|
    t.pattern = './spec/**/*{_spec.rb,.feature}'
  end
 
  namespace :spec do
    desc "Run the code examples in spec/acceptance"
    RSpec::Core::RakeTask.new(:acceptance => 'db:test:prepare') do |t|
      t.pattern = './spec/acceptance/**/*{_spec.rb,.feature}'
    end
  end
end
