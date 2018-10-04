class SearchResult < ApplicationRecord
  belongs_to :user
  has_many :links, dependent: :destroy, inverse_of: :search_result

  validates_presence_of :keyword, :total_results, :total_links, :html_code,
    :server_ip, :user_agent
  validates :keyword, uniqueness: true

  accepts_nested_attributes_for :links, allow_destroy: true
end
