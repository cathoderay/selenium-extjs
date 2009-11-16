
require 'rubygems'
require 'selenium/client'
require 'selenium-extjs/component/Component'
require 'selenium-extjs/component/Button'
require 'selenium-extjs/component/Field'
require 'selenium-extjs/component/Form'
require 'selenium-extjs/component/Grid'
require 'selenium-extjs/component/Panel'
require 'selenium-extjs/component/Window'


module Ext

  Ref = {
  :button => Button,
  :component => Component,
  :grid => Grid,
  :editorgrid => EditorGrid,
  :window => Window,
  :form => Form,
  :field => Field,
  :panel => Panel,
  :tabpanel => TabPanel
  }

  class Driver
    @@instance = nil
    def initialize(host="localhost", port="4444", browser="*firefox", 
                   url="http://www.extjs.com/", timeout_in_second=60)
      @@instance = ::Selenium::Client::Driver.new \
        :host => host,
        :port => port,
        :browser => browser,
        :url => url,
        :timeout_in_second => timeout_in_second
      @@instance.start_new_browser_session
    end

    def self.instance() 
      return @@instance
    end
  end
  
  def reg(xtype, clazz)
    Ref[xtype] = clazz
  end

  def self.build_cmp(id, parent)
    selenium = Ext::Driver::instance()     

    # if xtype == nil
    xtypes = selenium.get_eval("window.Ext.getCmp('#{id}').getXTypes()")
    p "#{id} => #{xtypes}"
    print "----"
    cls = xtypes.split("/").reverse.select do |el|
      # p  Ref
      # p el
      Ref.has_key? el.to_sym
    end
    p cls
    # print "****"
    # print Ref[cls.first().to_sym]
    # TODO: confused.
    return (Ref[cls.first().to_sym]).new(id, parent) if id != nil    
  end
    
  def self.find(args)
    selenium = Ext::Driver::instance()
    if args.kind_of? Hash
      
      exp = ""
      parent = nil
      
      xtype = nil
      args.each do |k,v|
        exp += case k
          # use para botões.
          when :icon_cls
            " (el.iconCls?(el.iconCls.indexOf('#{v}') != -1):false) && "
          when :title
            " (el.title?(el.title == '#{v}'):false) && "
          when :title_has
            " (el.title?(el.title.indexOf('#{v}') != -1):false) && "
          when :wait
            "" # empty
          when :text
            " (el.getText?(el.getText() == '#{v}'):false) && "
          when :xtype
            xtype = v
            " el.getXType() == '#{v}' && "
          when :xparent
            if v.kind_of? Ext::Component
              parent = v
              " el.findParentBy(function(o) { return o.getId() == '#{v.getId()}' }) && "
            else
              " el.findParentBy(function(o) { return o.getXType() == '#{v}' }) && "
            end
        end
      end
      exp = exp[0,exp.length - 3]
      p "window.Ext.ComponentMgr.all.find(function(el){ return #{exp}  }).getId()"

      # wait for element.
      if args.has_key?(:wait) && args[:wait]
        selenium.wait_for_condition("null != window.Ext.ComponentMgr.all.find(function(el){ return (#{exp}); })")
      end
      
      id = selenium.get_eval("window.Ext.ComponentMgr.all.find(function(el){ return (#{exp}); }).getId()")
      return build_cmp(id, parent)
    end
  end
end
