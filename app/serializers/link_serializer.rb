class LinkSerializer < ActiveModel::Serializer
  attributes :link_type, :title, :url, :keyword

  def keyword
    object.search_result.keyword
  end
end
