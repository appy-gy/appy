module Imagination
  module Pathfinder
    module_function

    def dir record, field
      id = record.id.gsub('-', '/')
      ::File.join public_dir, 'system', record.class.name.underscore, field.to_s, id
    end

    def path record, field, version = nil
      name = record.public_send field
      name = "#{version}_#{name}" if version
      ::File.join dir(record, field), name
    end

    def url record, field, version = nil
      path(record, field, version).remove(public_dir)
    end

    def public_dir
      Rails.root.join('public').to_s
    end
  end
end
