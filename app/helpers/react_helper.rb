module ReactHelper
  def react_render path, props: nil, tag: :div, prerender: true, **options
    options[:data] ||= {}
    options[:data][:component] = path
    options[:data][:props] = props.to_json
    content = react_context.render(path, props).html_safe if prerender
    content_tag tag, content, options
  end
end
