
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "gol_chido/version"

Gem::Specification.new do |spec|
  spec.name          = "gol_chido"
  spec.version       = GolChido::VERSION
  spec.authors       = ["Saul Rubio"]
  spec.email         = ["saulrubio98@hotmail.com"]

  spec.summary       = %q{This a gem for base of Conway's Game of Life and it's for 0 players}
  spec.description   = %q{You can waste time looking how all the cells moves in the matrix, it's kind a fun}
  spec.homepage      = "https://github.com/rubiocanino/game_of_life_chido"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] ="https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files         = Dir.glob("{bin,lb}**/*")
  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_dependency             'colorize', '~> 0.8.1'
  spec.add_dependency             'rspec'

end
