
require 'rubygems'
require 'selenium/client'
require 'selenium-extjs/Component'


module Ext

  class Driver
    # < Selenium::Client::Driver
    @@instance = nil
    def initialize()
      # TODO: params.
      @@instance = ::Selenium::Client::Driver.new \
        :host => "localhost",
        :port => 4444,
        :browser => "*firefox",
        :url => "http://www.extjs.com/",
        :timeout_in_second => 60
        
      @@instance.start_new_browser_session
      # @@instance.open "/"
      # @@instance = self
    end
    def self.instance() 
      return @@instance
    end
  end
    
  def self.find(args)
    selenium = Ext::Driver::instance()
    if args.kind_of? Hash
      
      exp = ""
      parent = nil
      
      xtype = nil
      args.each do |k,v|
        exp += case k
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

      if args.has_key?(:wait) && args[:wait]
        selenium.wait_for_condition("null != window.Ext.ComponentMgr.all.find(function(el){ return (#{exp}); })")
      end
      
      id = selenium.get_eval("window.Ext.ComponentMgr.all.find(function(el){ return (#{exp}); }).getId()")

      # melhorar :)
      ref = {
        :button => Button,
        :component => Component,
        :grid => Grid,
        :editorgrid => EditorGrid,
        :window => Window
        }
        

      # if xtype == nil
      xtypes = selenium.get_eval("window.Ext.getCmp('#{id}').getXTypes()")
      # p xtypes
      print "----"
      cls = xtypes.split("/").reverse.select do |el|
        # p  ref
        # p el
        ref.has_key? el.to_sym
      end
      p cls
      # print "****"
      # print ref[cls.first().to_sym]
      # TODO: confused.
      return (ref[cls.first().to_sym]).new(id, parent) if id != nil
    end
  end
end
