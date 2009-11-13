
require 'Component'

module Ext

  class Selenium
    @@instance = nil
    def initialize
      @@instance = self
    end
    def get_eval exp
      print exp
      return "1"
    end
    def self.instance() 
      return @@instance
    end
  end
    
  def self.find(args)
    selenium = Ext::Selenium::instance()
    if args.kind_of? Hash
      exp = ""
      args.each do |k,v|
        exp += case k
          when :xtype
            " el.getXType() == '#{v}' && "
          when :xparent
            if v.kind_of? Ext::Component
              " el.findParentBy(function(o) { return o.getId() == '#{v.getId()}' }) && "
            else
              " el.findParentBy(function(o) { return o.getXType() == '#{v}' }) && "
            end
        end
      end
      exp = exp[0,exp.length - 3]
      id = selenium.get_eval("window.Ext.ComponentMgr.all.find(function(el){ #{exp}}).getId()")
      case selenium.get_eval("window.Ext.getCmp('#{id}').getXType()")
      when "grid"
        # return Ext::Grid.new(id)
      else
        return Component.new(id) if id != nil
      end
    end
  end
end

# setup selenium
Ext::Selenium.new()

# find component "panel"
cmp = Ext::find(:xtype => "panel", :xparent => 'stream-list')

p "-----"

# find component "panel"
cmp2 = Ext::find(:xtype => "grid", :xparent => cmp)

# cmp2.check_all()
# cmp2.check_row :name => "Nome", :value => "fooo"
# cmp2.edit_cel :row => 2, :value => "NewValue"




