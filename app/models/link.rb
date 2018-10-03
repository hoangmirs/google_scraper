class Link < ApplicationRecord
  belongs_to :search_result

  enum link_type: [:non_ad, :top_ad, :bottom_ad]

  validates_presence_of :link_type, :title, :url

  class << self
    def query query_type, keyword
      send(query_type, keyword)
    end
    def adword_url_contains keyword
      adwords.where(link_type: [:top_ad, :bottom_ad]).where("url like ?", "%#{keyword}%")
    end

    def specific_url url
      where("url like ?", "%#{url}%")
    end

    def adwords
      where(link_type: [:top_ad, :bottom_ad])
    end
  end
end
