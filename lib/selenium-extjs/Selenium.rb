module Ext
  class Selenium < Selenium::Client::Driver
    def initialize(args)
      super(args)
    end  

    def find_ext(args)
      if args.kind_of? Hash        
        exp = ""
        parent = nil
        
        xtype = nil
        filters = []        
        args.each do |k,v|
          filters << case k
            # use para botões.
            when :icon_cls
              " (el.iconCls?(el.iconCls.indexOfind_extf('#{v}') != -1):false) "
            when :title
              " (el.title?(el.title == '#{v}'):false) "
            when :title_has
              " (el.title?(el.title.indexOf('#{v}') != -1):false) "
            when :wait
              nil
            when :text
              " (el.getText?(el.getText() == '#{v}'):false) "
            when :xtype
              xtype = v
              Ext::condition_xtype(v)
            when :xparent
              if v.is_a? Ext::Component
                parent = v
                " el.findParentBy(function(o) { return o.getId() == '#{v.getId()}' }) "
              else
                " el.findParentBy(function(o) { return o.getXType() == '#{v}' })  "
              end
            else
              Ext::condition_default(k, v)
          end
        end
        exp = filters.compact().join(" && ")
        p "window.Ext.ComponentMgr.all.find(function(el){ return #{exp}  }).getId()"

        # wait for element.
        if args.has_key?(:wait) && args[:wait]
          wait_for_condition("null != window.Ext.ComponentMgr.all.find(function(el){ return (#{exp}); })")
        end
        
        id = get_eval("window.Ext.ComponentMgr.all.find(function(el){ return (#{exp}); }).getId()")

        return get_cmp(id, parent)
      end
    end

    def wait_for_component_visible(id)
      wait_for_condition("window.Ext.getCmp('#{id}').isVisible()")
    end

    def get_cmp(id, parent=nil)
      xtypes = get_eval("window.Ext.getCmp('#{id}').getXTypes()")
      selected_xtype = nil
      for xtype in xtypes.split("/").reverse() do
        if Ext::ComponentMgr::registered? xtype.to_sym
          selected_xtype = xtype.to_sym
          break
        end
      end
      return Ext::ComponentMgr::create selected_xtype, id, parent, self
    end
  end
end