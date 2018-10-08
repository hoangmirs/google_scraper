class Link < ApplicationRecord
  belongs_to :search_result

  enum link_type: [:non_ad, :top_ad, :bottom_ad]

  validates_presence_of :link_type, :title, :url
end
