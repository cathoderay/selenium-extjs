
require 'test/unit'
require 'selenium-extjs'

class FindTest < Test::Unit::TestCase

  def test_filter_by_initial_config
    assert_equal Ext::condition_default("foo", "bar"), "((el.initialConfig.foo && el.initialConfig.foo == 'bar'))"
    assert_equal Ext::condition_default(:foo, "bar"), "((el.initialConfig.foo && el.initialConfig.foo == 'bar'))"
  end

  def test_filter_by_initial_config_with_has
    assert_equal Ext::condition_default("foo_has", "bar"), "((typeof el.initialConfig.foo == 'string' && el.initialConfig.foo.indexOf('bar') != -1)||(el.initialConfig.foo && el.initialConfig.foo == 'bar'))"
    assert_equal Ext::condition_default(:foo_has, "bar"), "((typeof el.initialConfig.foo == 'string' && el.initialConfig.foo.indexOf('bar') != -1)||(el.initialConfig.foo && el.initialConfig.foo == 'bar'))"

  end

  def test_filter_by_xtype
    assert_equal Ext::condition_xtype("panel"),  "(el.getXType() == 'panel')"
    assert_equal Ext::condition_xtype(:panel),  "(el.getXType() == 'panel')"
  end

  
  # def test_filter_by_parent
  #   assert_equal Ext::condition_parent(Component::new(1,nil,nil)), "()"
  # end

end
