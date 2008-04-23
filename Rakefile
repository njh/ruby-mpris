require 'rubygems'
require 'rake'
require 'rake/clean'
require 'rake/gempackagetask'
require 'rake/rdoctask'
require 'rake/testtask'

NAME = "ruby-mpris"
VERS = "0.0.1"
CLEAN.include ['pkg', 'rdoc']

Gem::manage_gems

spec = Gem::Specification.new do |s|
  s.name              = NAME
  s.version           = VERS
  s.author            = "Nicholas J Humfrey"
  s.email             = "njh@aelius.com"
  s.homepage          = "http://mpris.rubyforge.org"
  s.platform          = Gem::Platform::RUBY
  s.summary           = "A library to control MPRIS based Media Players" 
  s.rubyforge_project = "mpris" 
  s.description       = "The mpris gem allows you to control media players that follow the MPRIS specification."
  s.files             = FileList["lib/mpris.rb", "lib/mpris/*", "spec/*"]
  s.require_path      = "lib"
  s.has_rdoc          = true
  s.extra_rdoc_files  = ["README", "NEWS", "COPYING"]  
  s.test_file         = "test/runtest.rb"
end

task :build_package => [:repackage]
Rake::GemPackageTask.new(spec) do |pkg|
  #pkg.need_zip = true
  #pkg.need_tar = true
  pkg.gem_spec = spec
end

desc "Default: run unit tests."
task :default => :test

desc "Run all the tests"
Rake::TestTask.new(:test) do |t|
  t.libs << "lib"
  t.pattern = "test/runtest.rb"
  t.verbose = true
end

desc "Generate documentation for the library"
Rake::RDocTask.new("rdoc") { |rdoc|
  rdoc.rdoc_dir = 'rdoc'
  rdoc.title    = "ruby-mpris Documentation"
  rdoc.options << '--line-numbers' << '--inline-source'
  rdoc.main = "README"
  rdoc.rdoc_files.include("README", "NEWS", "COPYING", "lib/mpris.rb", "lib/mpris/*.rb")
}

desc "Upload rdoc to rubyforge"
task :upload_rdoc => [:rdoc] do
  sh %{/usr/bin/scp -r -p rdoc/* mpris.rubyforge.org:/var/www/gforge-projects/mpris}
end
