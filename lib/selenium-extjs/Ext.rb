
require 'rubygems'
require 'selenium/client'
require 'selenium-extjs/Selenium'
require 'selenium-extjs/component/Component'
require 'selenium-extjs/component/Button'
require 'selenium-extjs/component/Field'
require 'selenium-extjs/component/Form'
require 'selenium-extjs/component/Grid'
require 'selenium-extjs/component/Panel'
require 'selenium-extjs/component/Window'


module Ext
  def self.reg(xtype, cls)
    Ext::ComponentMgr.register_type(xtype, cls)
  end   

  def self.create(xtype, id, parent, selenium)
    Ext::ComponentMgr.create(xtype, cls)
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
