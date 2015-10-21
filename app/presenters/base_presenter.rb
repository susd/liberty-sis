class BasePresenter
  def initialize(object, template)
    @object = object
    @template = template
  end
  
  private
  
  def self.presents(name)
    define_method(name) do
      @object
    end
  end
  
  def tpl
    @template
  end
  
  def method_missing(name, *args, &block)
    if tpl.respond_to? name.to_sym
      tpl.send(name, *args, &block)
    else
      super
    end
  end
end