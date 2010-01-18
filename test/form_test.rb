
require 'test/unit'
require 'selenium-extjs'
require 'setup'

class FormTest < Test::Unit::TestCase

  include Setup

  def _test_very_simple_form

    @s.open 'deploy/dev/examples/form/dynamic.html'

    # search for editorgrid component.
    form = @s.find_ext(:xtype => "form", :title_has => 'Simple')

    assert form.is_a? Ext::Form
    assert_equal form.fields.length, 5

    # first is required
    form.fields[:first].blur
    assert  !form.fields[:first].valid?
    form.fields[:first].value = "Jonny"    
    assert  form.fields[:first].valid?

    # last isn't required
    form.fields[:last].blur
    assert  form.fields[:last].valid?

    # email has format
    form.fields[:email].value = 'invalid_email'
    assert  !form.fields[:email].valid?
    form.fields[:email].value = 'valid@email.br'
    assert  form.fields[:email].valid?
    
    # combo don't implemented
  end

  def test_adding_fieldsets

    @s.open 'deploy/dev/examples/form/dynamic.html'

    # search for editorgrid component.
    form = @s.find_ext(:xtype => "form", :title_has => 'FieldSet')
    
    # first fieldset is closed
    user_information = form.items[0]
    assert user_information.is_a? Ext::FieldSet
    assert user_information.collapsed



    # second is opened.
    phone = form.items[1]
    assert phone.is_a? Ext::FieldSet
    assert !phone.collapsed
    
    phone.items.each do |f|
      assert f.is_a? Ext::Field
      f.value = "Loren Ipsun"
    end
    

    user_information.collapsed = false

    user_information.items.each do |f|
      assert f.is_a? Ext::Field
      f.value = "Loren Ipsun"
    end


    phone.collapsed = true
  end
  
#  def test_a_little_complex
#  end
  
#  def test_form_as_a_tab_panel
#  end
  
#  def test_form_with_tab_panel
#  end
  
end




