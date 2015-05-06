module RenderError
  def render_error error = ''
    error = error.full_messages.join("\n") if error.kind_of? ActiveModel::Errors
    render json: { error: error }, status: 400
  end
end
