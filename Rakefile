require 'rubygems'
require 'rake'
require 'rake/clean'
require 'rake/gempackagetask'
require 'rake/rdoctask'
require 'rake/testtask'

NAME = "ruby-mpris"
VERS = "0.1.0"
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
  s.files             = FileList["lib/mpris.rb", "lib/mpris/*"]
  s.require_path      = "lib"
  
  # rdoc
  s.has_rdoc          = true
  s.extra_rdoc_files  = ["README", "NEWS", "COPYING"]
  
  # Dependencies
  s.add_dependency "ruby-dbus"
  s.add_dependency "rake"
end

desc "Default: package up the gem."
task :default => :package

task :build_package => [:repackage]
Rake::GemPackageTask.new(spec) do |pkg|
  pkg.need_zip = false
  pkg.need_tar = true
  pkg.gem_spec = spec
end

desc "Run :package and install the resulting .gem"
task :install => :package do
  sh %{#{SUDO} gem install --local pkg/#{NAME}-#{VERSION}.gem}
end

desc "Run :clean and uninstall the .gem"
task :uninstall => :clean do
  sh %{#{SUDO} gem uninstall #{NAME}}
end



## Testing
#desc "Run all the specification tests"
#Rake::TestTask.new(:spec) do |t|
#  t.warning = true
#  t.verbose = true
#  t.pattern = 'spec/*_spec.rb'
#end
  
desc "Check the syntax of all ruby files"
task :check_syntax do
  `find . -name "*.rb" |xargs -n1 ruby -c |grep -v "Syntax OK"`
  puts "* Done"
end



## Documentation
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
