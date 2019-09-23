require "bundler/gem_tasks"
require "rspec/core/rake_task"
require "graped_moviez"

# require 'graped_moviez'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

namespace :db do
  desc "Run migrations"
  task :migrate do |t, args|
    require "sequel/core"
    Sequel.extension :migration
    ARGV.each { |a| task a.to_sym do ; end }
    version = ARGV[1].to_i if ARGV[1]
    env = ARGV[2].to_sym if ARGV[2]
    db_url = env == :test ? 'postgres://postgres@localhost:5433/graped_moviez_test' : ENV.fetch("DATABASE_URL")
    Sequel.connect(db_url) do |db|
      Sequel::Migrator.run(db, "lib/db/migrations", target: version)
    end
  end
  desc "Fills the DB in from seed files"
  task :seed, [:env] do |t, args|
    require 'sequel'
    require 'sequel/extensions/seed'    
    Sequel.extension :seed
    env = args[:env].to_sym if args[:env]
    db_url = env == :test ? 'postgres://postgres@localhost:5433/graped_moviez_test' : ENV.fetch("DATABASE_URL")
    Sequel.connect(db_url) do |db|
      Sequel::Seeder.apply(db, "lib/db/seeds")
    end
  end
end

namespace :grape do
  desc "Condensed API Routes"
  task :routes do
    mapped_prefix = '/api/v1' # where mounted in routes.rb
    format = "%46s %3s %7s %s"
    GrapedMoviez::Api::V1::Api.routes.each do |grape_route|
      info = grape_route.instance_variable_get :@options

      puts format % [
        info[:description] ? info[:description][0..45] : '',
        info[:version],
        info[:method],
        mapped_prefix + grape_route.path
      ]
    end
  end
end
