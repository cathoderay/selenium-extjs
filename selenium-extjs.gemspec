# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{selenium-extjs}
  s.version = "0.0.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ronald Andreu Kaiser"]
  s.date = %q{2009-11-18}
  s.email = %q{raios.catodicos@gmail.com}
  s.extra_rdoc_files = ["README.rdoc"]
  s.files = ["lib/selenium-extjs.rb", "lib/selenium-extjs", "lib/selenium-extjs/Selenium.rb", "lib/selenium-extjs/Ext.rb", "lib/selenium-extjs/component", "lib/selenium-extjs/component/Grid.rb", "lib/selenium-extjs/component/Combo.rb", "lib/selenium-extjs/component/Component.rb", "lib/selenium-extjs/component/Panel.rb", "lib/selenium-extjs/component/Window.rb", "lib/selenium-extjs/component/Field.rb", "lib/selenium-extjs/component/FieldSet.rb", "lib/selenium-extjs/component/Form.rb", "lib/selenium-extjs/component/Container.rb", "lib/selenium-extjs/component/BoxComponent.rb", "lib/selenium-extjs/component/Button.rb", "lib/selenium-extjs/component/ListView.rb", "README.rdoc"]
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
  s.add_dependency 'json', '1.2.4'
  s.add_dependency 'selenium-client', '1.2.18'
end
