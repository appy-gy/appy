module ReactHelper
  def react_store storage, data
    add_react_storage storage, data
  end

  def react_render component, props: nil, tag: :div, prerender: true, **options
    props = props.to_json
    options[:data] ||= {}
    options[:data][:component] = component
    options[:data][:props] = props
    content = React::Renderer.render(component, props, react_storages).html_safe if prerender
    content_tag tag, content, options
  end
end
