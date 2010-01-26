
require 'rubygems'
require 'selenium/client'
require 'selenium-extjs/Selenium'
require 'selenium-extjs/component/Component'
require 'selenium-extjs/component/Panel'
require 'selenium-extjs/component/Button'
require 'selenium-extjs/component/Field'
require 'selenium-extjs/component/Form'
require 'selenium-extjs/component/Grid'
require 'selenium-extjs/component/Window'
require 'selenium-extjs/component/Combo'
require 'selenium-extjs/component/FieldSet'
require 'selenium-extjs/component/BoxComponent'
require 'selenium-extjs/component/Container'

require 'json'


module Ext
  def self.reg(xtype, cls)
    Ext::ComponentMgr.register_type(xtype, cls)
  end

  def self.create(xtype, id, parent, selenium)
    Ext::ComponentMgr.create(xtype, cls)
  end

  def self.condition_parent(cmp)
    "(TODO)"
  end

  def self.condition_xtype(xtype)
    "(el.getXType() == '#{xtype}')"
  end

  def self.condition_default(key, value)
    key = key.to_s if key.is_a? Symbol
    ret = "("
    if key.end_with? '_has'
      key = key.gsub(/_has$/, '')
      ret += "(typeof el.initialConfig.#{key} == 'string' && el.initialConfig.#{key}.indexOf('#{value}') != -1)||"
    end
    ret += "(el.initialConfig.#{key} && el.initialConfig.#{key} == '#{value}')"
    ret += ")"
    ret
  end

  # build arguments list.
  def self.arguments(args)
    if args.is_a? Array
      return args.to_json[1..-2] || ""
    else
      return args.to_json 
    end
  end

  def self.build_remote_call(id, method_name, arguments)
    code = []
    code << "(function(_) {"
    code << "var r;"
    code << "  if (typeof _.#{method_name} == 'function') {"
    code << "    r = _.#{method_name}(#{arguments});"
    code << "  } else {"
    code << "  r = _.#{method_name};"
    code << "  }"
    code << "if (typeof r.getId == 'function' ) {" # return hash map
    code << "    return 'JSON:' + window.Ext.util.JSON.encode({\"cmpid\":r.getId()});"
    code << "  } else {"
    code << "    return r;"
    code << "  }"
    code << "})(window.Ext.getCmp('#{id}'));"
    (code.collect {|t| t.strip }).join
    puts "code generated"
    puts code
    return (code.collect {|t| t.strip }).join
  end

  # convert some ruby-style methods to ext-style
  def self.extfy(method_name)
    if method_name.end_with? '?'
      method_name = "is_" + method_name
      method_name.chop!
    end
    tokens = method_name.split("_")
    tmp = tokens.shift
    tokens.collect! {|t| t.capitalize }
    tokens.unshift tmp
    return tokens.join
  end

  class ComponentMgr
    @@all = {}

    def self.register_type(xtype, cls)
        @@all[xtype] = cls
    end

    def self.registered?(xtype)
      @@all.has_key? xtype
    end

    def self.create(xtype, id, parent, selenium)
      @@all[xtype].new(id, parent, selenium)
    end
  end

  {
    :button => Button,
    :component => Component,
    :container => Container,
    :boxcomponent => BoxComponent,
    :grid => Grid,
    :editorgrid => EditorGrid,
    :window => Window,
    :form => Form,
    :field => Field,
    :panel => Panel,
    :tabpanel => TabPanel,
    :combo => Combo,
    :fieldset => FieldSet
  }.each do | xtype, cls |
    Ext::reg(xtype, cls)
  end

end
