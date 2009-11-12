require 'rake'
require 'rake/testtask'
require 'rake/rdoctask'
require 'rake/gempackagetask'
 
$LOAD_PATH.unshift("lib")

require 'selenium-extjs'

spec = Gem::Specification.new do |s|
  s.name = "selenium-extjs"
  s.version = SeleniumExtJs::VERSION
  s.email = "raios.catodicos@gmail.com"
  s.version = "0.0.1"
  s.author = "Ronald Andreu Kaiser"
  s.email = "raios.catodicos@gmail.com"
  s.homepage = "http://github.com/cathoderay/selenium-extjs"
  s.platform = Gem::Platform::RUBY
  s.summary = "A framework in ruby to test your extjs applications with selenium "
  s.files = FileList["{lib}/**/*"].to_a
  s.has_rdoc = false
  s.extra_rdoc_files = ["README"]  
  s.require_paths = ["lib"]
  # TODO: add dependency selenium-client (1.2.17)
end
 
Rake::GemPackageTask.new spec do |pkg|
  # pkg.need_tar = true
  # pkg.need_zip = true
end
 
desc "Generate a gemspec file for GitHub"
task :gemspec do
  File.open("#{spec.name}.gemspec", 'w') do |f|
    f.write spec.to_ruby
  end
end