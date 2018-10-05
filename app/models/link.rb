class Link < ApplicationRecord
  belongs_to :search_result

  enum link_type: [:non_ad, :top_ad, :bottom_ad]

  validates_presence_of :link_type, :title, :url

  STRING_OCCURS_PATTERN = /(\d)\+(\W)/
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

    def string_occurs keyword
      return [] unless STRING_OCCURS_PATTERN.match? keyword
      number, string = keyword.split "+"
      query = <<-MYSQL
        SELECT
          *
        FROM links
        WHERE
          ROUND (
            (
                LENGTH(url)
                - LENGTH( REPLACE ( url, '#{string}', '') )
            ) / LENGTH('#{string}')
          ) >= #{number}
          OR
          ROUND (
            (
                LENGTH(title)
                - LENGTH( REPLACE ( title, '#{string}', '') )
            ) / LENGTH('#{string}')
          ) >= #{number}
      MYSQL
      find_by_sql query
    end
  end
end
