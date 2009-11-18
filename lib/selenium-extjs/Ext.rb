
require 'rubygems'
require 'selenium/client'
# require 'selenium-extjs/Selenium'
require 'selenium-extjs/component/Component'
require 'selenium-extjs/component/Button'
require 'selenium-extjs/component/Field'
require 'selenium-extjs/component/Form'
require 'selenium-extjs/component/Grid'
require 'selenium-extjs/component/Panel'
require 'selenium-extjs/component/Window'
require 'json'


module Ext
  def self.reg(xtype, cls)
    Ext::ComponentMgr.register_type(xtype, cls)
  end   

  def self.create(xtype, id, parent, selenium)
    Ext::ComponentMgr.create(xtype, cls)
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
    code << "  var r;"
    code << "  if (typeof _.#{method_name} == 'function') {"
    code << "    r = _.#{method_name}(#{arguments});"
    code << "  } else {"
    code << "    r = _.#{method_name};"
    code << "  }"
    code << "  if (typeof r.getId == 'function') {" # return hash map
    code << "    return Ext.util.JSON.encode({\"id\":r.getId()});"
    code << "  } else {"
    code << "    return r;"
    code << "  }"
    code << "}(window.Ext.getCmp('#{id}'));"
    (code.collect {|t| t.strip }).join
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
    :grid => Grid,
    :editorgrid => EditorGrid,
    :window => Window,
    :form => Form,
    :field => Field,
    :panel => Panel,
    :tabpanel => TabPanel
  }.each do | xtype, cls |
    Ext::reg(xtype, cls)
  end

end
