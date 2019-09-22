require "bundler/gem_tasks"
require "rspec/core/rake_task"
# require 'graped_moviez'

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

namespace :db do
  desc "Run migrations"
  task :migrate, [:version] do |t, args|
    require "sequel/core"
    Sequel.extension :migration
    version = args[:version].to_i if args[:version]
    Sequel.connect(ENV.fetch("DATABASE_URL")) do |db|
      Sequel::Migrator.run(db, "lib/db/migrations", target: version)
    end
  end
  task :seed do |t, args|
    require 'sequel'
    require 'sequel/extensions/seed'    
    Sequel.extension :seed
    Sequel.connect(ENV.fetch("DATABASE_URL")) do |db|
      Sequel::Seeder.apply(db, "lib/db/seeds")
    end
  end
end
