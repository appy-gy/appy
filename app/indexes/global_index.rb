class GlobalIndex < Chewy::Index
  define_type Rating.published do
    field :title
  end

  define_type User.with_name do
    field :name
  end
end
