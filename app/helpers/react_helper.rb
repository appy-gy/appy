module ReactHelper
  def react_render component, props: {}, tag: :div, prerender: true, **options
    props = props.to_json
    options[:data] ||= {}
    options[:data][:component] = component
    options[:data][:props] = props
    content = prerender ? React::Renderer.render(component, props).html_safe : nil
    content_tag tag, content, options
  end
end
