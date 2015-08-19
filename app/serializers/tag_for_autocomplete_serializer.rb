class TagForAutocompleteSerializer < TagSerializer
  self.root = :tag

  attributes :number_of_uses
end
