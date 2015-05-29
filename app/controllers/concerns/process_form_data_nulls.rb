module ProcessFormDataNulls
  extend ActiveSupport::Concern

  included do
    before_action :process_form_data_nulls, if: -> { request.content_type == 'multipart/form-data' }
  end

  def process_form_data_nulls
    replace_nulls request.parameters
  end

  private

  def replace_nulls params
    return params unless params.respond_to? :each
    params.each do |key, value|
      params[key] = case value
      when Hash then replace_nulls value
      when Array then value.map! { |v| v == 'null' ? nil : replace_nulls(v) }
      when 'null' then nil
      else value
      end
    end
  end
end
