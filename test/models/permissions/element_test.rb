require 'test_helper'

class Permissions::ElementTest < ActiveSupport::TestCase

  setup do
    @view = Permissions::Ability.new(:view)
    @edit = Permissions::Ability.new(:edit)

    @own = Permissions::Level.new(:own)
    @site = Permissions::Level.new(:site)
  end

  test "Edit ranked above view" do
    assert @edit > @view
  end

  test "Own ranked below site" do
    assert @own < @site
  end

end
