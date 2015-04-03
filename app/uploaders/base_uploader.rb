class BaseUploader < CarrierWave::Uploader::Base
  def store_dir
    ['system', model.class.to_s.underscore, mounted_as, *model.id.split('-')].join('/')
  end
end
