
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "graped_moviez/version"

Gem::Specification.new do |spec|
  spec.name          = "graped_moviez"
  spec.version       = GrapedMoviez::VERSION
  spec.authors       = ["Gaston Trujillo"]
  spec.email         = ["gaston.trujillo.java@gmail.com"]

  spec.summary       = "lightweight ruby API for movies and reservations"
  spec.description   = "lightweight ruby API for movies and reservations using ruby, grape and sequel"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["source_code_uri"] = "https://github.com/gtrujillop/graped_moviez"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency "require_all", "~> 2.0.0"
  spec.add_runtime_dependency "bundler", "~> 2.0"
  spec.add_runtime_dependency "rake", "~> 10.0"
  spec.add_runtime_dependency "rspec", "~> 3.0"
  spec.add_runtime_dependency "factory_bot", "~> 5.0.0"
  spec.add_runtime_dependency "grape", "~> 1.2.3"
  spec.add_runtime_dependency "sequel", "5.23.0"
  spec.add_runtime_dependency "sequel-seed", "1.1.2"
  spec.add_runtime_dependency "dry-transaction"
  spec.add_runtime_dependency "pg", "1.1.4"
  spec.add_runtime_dependency "dry-configurable"
  spec.add_runtime_dependency "byebug"

end
