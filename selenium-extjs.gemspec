# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{selenium-extjs}
  s.version = "0.0.1"

  # dependency: json
  
  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ronald Andreu Kaiser"]
  s.date = %q{2009-11-12}
  s.email = %q{raios.catodicos@gmail.com}
  s.extra_rdoc_files = ["README"]
  s.files = ["README"]
  s.homepage = %q{http://github.com/cathoderay/selenium-extjs}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.3.5}
  s.summary = %q{A framework in ruby to test your extjs applications with selenium}

  if s.respond_to? :specification_version then
    current_version = Gem::Specification::CURRENT_SPECIFICATION_VERSION
    s.specification_version = 3

    if Gem::Version.new(Gem::RubyGemsVersion) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
