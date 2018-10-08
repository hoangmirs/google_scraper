class LinksQuery
  attr_reader :relation

  STRING_OCCURS_PATTERN = /(\d)\+(\W)/

  def initialize(relation = Link.all)
    @relation = relation
  end

  def query query_type, keyword
    send(query_type, keyword)
  end

  def adword_url_contains keyword
    adwords.where(link_type: [:top_ad, :bottom_ad]).where("url like ?", "%#{keyword}%")
  end

  def specific_url url
    relation.where("url like ?", "%#{url}%")
  end

  def adwords
    relation.where(link_type: [:top_ad, :bottom_ad])
  end

  def string_occurs keyword
    return [] unless STRING_OCCURS_PATTERN.match? keyword
    number, string = keyword.split "+"
    query = <<-MYSQL
      SELECT
        *, search_results.keyword
      FROM links
      INNER JOIN search_results ON search_results.id = links.search_result_id
      WHERE
        ROUND (
          (
              LENGTH(url)
              - LENGTH( REPLACE ( url, :string, '') )
          ) / LENGTH(:string)
        ) >= :number
        OR
        ROUND (
          (
              LENGTH(title)
              - LENGTH( REPLACE ( title, :string, '') )
          ) / LENGTH(:string)
        ) >= :number
    MYSQL
    relation.find_by_sql [query, {string: string, number: number}]
  end
end
