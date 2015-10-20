module ApplicationHelper
  def present(object, klass = nil)
    klass ||= "#{object.class}Presenter".constantize
    presenter = klass.new(object, self)
    yield presenter if block_given?
    presenter
  end

  def active_li(name, &block)
    css_class = (controller_name == name) ? 'active' : nil
    content_tag(:li, class: css_class, &block)
  end

  def job_polling_link(name, start_path, check_path, opts = {})
    options = {
      method: :patch,
      data: {
        behavior: 'job_poller',
        check_url: check_path,
        generate_url: start_path,
        loading_text: 'Building PDF',
        finish_text: 'View PDF'
      },
      remote: true,
      class: 'btn btn-default'
    }.merge!(opts)
    link_to name, start_path, options
  end
end
