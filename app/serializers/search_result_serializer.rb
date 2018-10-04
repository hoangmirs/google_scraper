class SearchResultSerializer < ActiveModel::Serializer
  attributes :id, :keyword, :total_results, :total_links, :user
  attribute :results, if: :show_detail?

  def user
    object.user.email
  end

  def results
    ActiveModel::Serializer::CollectionSerializer.new object.links
  end

  def show_detail?
    @instance_options[:detail] == true
  end
end
