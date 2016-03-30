gem 'rubocop', '>=0.33.0'
gem 'test-kitchen', '>= 1.2'
gem 'kitchen-ec2', github: 'test-kitchen/kitchen-ec2'

require 'rspec/core/rake_task'
require 'rubocop/rake_task'
require 'foodcritic'
require 'kitchen'

# Style tests. Rubocop and Foodcritic
namespace :style do
  desc 'Run Ruby style checks'
  RuboCop::RakeTask.new(:ruby)

  desc 'Run Chef style checks'
  FoodCritic::Rake::LintTask.new(:chef) do |t|
    t.options = {
      fail_tags: ['any'],
      tags: ['~FC005', '~FC003']
    }
  end
end

desc 'Run all style checks'
task style: ['style:chef', 'style:ruby']

# Rspec and ChefSpec
desc 'Run ChefSpec examples'
RSpec::Core::RakeTask.new(:spec)

desc 'Run all tests on Travis'
task travis: %w(style spec)

# Integration tests. Kitchen.ci
namespace :integration do
  desc 'Run Test Kitchen with Vagrant'
  task :vagrant do
    Kitchen.logger = Kitchen.default_file_logger
    Kitchen::Config.new.instances.each do |instance|
      instance.test(:always)
    end
  end
  task :ec2 do
    Kitchen.logger = Kitchen.default_file_logger
    @loader = Kitchen::Loader::YAML.new(project_config: './.kitchen.ec2.yml')
    config = Kitchen::Config.new(loader: @loader)
    config.instances.each do |instance|
      instance.test(:always)
    end
  end

  task :ec2Params do
	puts 'This will print all parameters used by Test Kitchen:'
	puts 'This is the PATH environment: ', ENV['PATH'] 
	puts 'AWS_SSH_KEY: ', ENV['AWS_SSH_KEY']
	puts 'AWS_SECURITY_GROUPS: ', ENV['AWS_SECURITY_GROUPS']
	puts 'AWS_REGION: ', ENV['AWS_REGION']
	puts 'AWS_AVAILABILITY_ZONE: ', ENV['AWS_AVAILABILITY_ZONE']
	puts 'AWS_SUBNET: ', ENV['AWS_SUBNET']
	puts 'AWS_USERNAME: ', ENV['AWS_USERNAME']
	puts 'AWS_PLATFORM_NAME: ', ENV['AWS_PLATFORM_NAME']
	puts 'AWS_AMI_ID: ', ENV['AWS_AMI_ID']
	puts 'INSTANCE_SIZE: ', ENV['INSTANCE_SIZE']
	puts 'USER_DATA_PATH: ', ENV['USER_DATA_PATH']
	puts 'SUMO_ACCESS_ID: ', ENV['SUMO_ACCESS_ID']
	puts 'SUMO_ACCESS_KEY: ', ENV['SUMO_ACCESS_KEY']
  end
end

# Default
task default: %w(style spec integration:vagrant)
task ec2: %w(style spec integration:ec2)
task test: %w(style spec)
