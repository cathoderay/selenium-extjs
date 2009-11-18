
require 'test/unit'

$LOAD_PATH.unshift("../lib")

require 'selenium-extjs'

class FunctionTest < Test::Unit::TestCase

  def test_for_underscore_method
    assert_equal Ext::extfy("get_cmp"), "getCmp"
    assert_equal Ext::extfy("get_foo_bar"), "getFooBar"
  end

  def test_for_normal_method
    assert_equal Ext::extfy("getCmp"), "getCmp"
    assert_equal Ext::extfy("getSomeMethod"), "getSomeMethod"
    assert_equal Ext::extfy("method"), "method"
  end

  def test_for_boolean_method 
    assert_equal Ext::extfy("valid?"), "isValid"
  end
  
  def test_arguments_convertion
    assert_equal Ext::arguments([1,'foo', true, 0.0]), '1,"foo",true,0.0'
    #emprt
    assert_equal Ext::arguments([]), ''
    # arrays
    assert_equal Ext::arguments([[1,2,3,4]]), '[1,2,3,4]'
    # simple elements
    assert_equal Ext::arguments("string"), '"string"'
    assert_equal Ext::arguments(1), '1'
    assert_equal Ext::arguments(true), 'true'

  end

  # def test_call_method
  #   Ext::build_remote_call(1, "foo", [1,2,3,4])
  # end

  
end