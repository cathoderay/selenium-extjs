
require 'test/unit'
require 'selenium-extjs'
require 'setup'

class FormTest < Test::Unit::TestCase

  include Setup

  def test_very_simple_form

    @s.open 'deploy/dev/examples/form/dynamic.html'

    # search for editorgrid component.
    form = $s.find_ext(:xtype => "form", :title_has => 'Simple')
    form.fields.each do |name, field|
      p name
      p field.value
      p field.value = "Loren Ipsun"
    end
    assert_false form.fields[:email].valid?
    form.fields[:email].value = 'myemail@domain.br'
  end

  def test_adding_fieldsets
    assert_true form.fields[:email].valid?

    # search for editorgrid component.
    form = $s.find_ext(:xtype => "form", :title_has => 'FieldSet')

    form.fields.each do |name, field|
      p name
      p field.value
    end
  end
  
  def test_a_little_complex
    
  end
  
  def test_form_as_a_tab_panel
  end
  
  def test_form_with_tab_panel
  end
  
end




