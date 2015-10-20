module ApplicationHelper
  def active_li(name, &block)
    css_class = (controller_name == name) ? 'active' : nil
    content_tag(:li, class: css_class, &block)
  end
end
