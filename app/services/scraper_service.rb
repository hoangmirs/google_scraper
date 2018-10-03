class ScraperService < BaseService
  attr_reader :keyword, :document, :query_keyword, :user_id, :error, :result
  BASE_URL = "https://www.google.com/search?q="
  ENCODING = "UTF-8"
  TOP_ADS_CSS_CLASS = "#tads .ads-ad"
  BOTTOM_ADS_CSS_CLASS = "#tadsb .ads-ad"
  RIGHT_ADS_CSS_CLASS = ""
  NON_ADS_CSS_CLASS = ".srg .r"
  TOTAL_RESULT_CSS_CLASS = "#resultStats"

  def initialize keyword, user_id
    @keyword = keyword
    @user_id = user_id
    @query_keyword = keyword.gsub /\s/, "+"
    @error = ""
  end

  def perform
    @document = get_document
    save_result
  end

  private
  def save_result
    begin
      links_attributes = []
      non_ads_links_information(non_ads_links).each do |link|
        links_attributes << {
          link_type: Link.link_types[:non_ad],
          title: link[:title],
          url: link[:url]
        }
      end
      ads_links_information(top_ads_links).each do |link|
        links_attributes << {
          link_type: Link.link_types[:top_ad],
          title: link[:title],
          url: link[:url]
        }
      end
      ads_links_information(bottom_ads_links).each do |link|
        links_attributes << {
          link_type: Link.link_types[:bottom_ad],
          title: link[:title],
          url: link[:url]
        }
      end
      total_links = links_attributes.size
      @result = SearchResult.create! keyword: keyword,
        total_results: total_results,
        total_links: total_links, html_code: html_code, user_id: user_id,
        links_attributes: links_attributes
    rescue Exception => error
      @error = error.message
      $stderr.puts "Save search result failed: #{error.message}"
    end
  end

  def get_document
    url = "#{BASE_URL}#{query_keyword}"
    begin
      uri = URI.parse(url)
    rescue URI::InvalidURIError
      uri = URI.parse(URI.escape(url))
    end
    @response = open uri, "User-Agent" => UserAgentRandomService.perform
    Nokogiri::HTML @response, nil, ENCODING
  end

  def total_results
    document.at_css(TOTAL_RESULT_CSS_CLASS).text
      .gsub(/[,.]/, '').scan(/\d+/).first.to_i
  end

  def non_ads_links
    document.css NON_ADS_CSS_CLASS
  end

  def top_ads_links
    document.css TOP_ADS_CSS_CLASS
  end

  def bottom_ads_links
    document.css BOTTOM_ADS_CSS_CLASS
  end

  def non_ads_links_information links
    links.map do |link|
      {
        title: link.text,
        url: link.at_css("a").attr("href")
      }
    end
  end

  def ads_links_information links
    links.map do |link|
      {
        title: link.at_css("h3").content,
        url: link.at_css("cite").content
      }
    end
  end

  def html_code
    document.to_html
  end
end
