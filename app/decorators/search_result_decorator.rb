class SearchResultDecorator < ApplicationDecorator
  delegate_all

  def keyword_display
    h.link_to object.keyword, get_link_keyword, target: :_blank
  end

  def total_results_display
    h.number_with_delimiter object.total_results
  end

  private
  def get_link_keyword
    "https://google.com/search?q=#{object.keyword.gsub /\s/, "+"}"
  end
end
