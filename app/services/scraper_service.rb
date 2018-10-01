class ScraperService < BaseService
  attr_reader :document
  BASE_URL = "https://www.google.com/search?q="
  USER_AGENT = "Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/69.0.3497.100 Safari/537.36"
  ENCODING = "UTF-8"
  TOP_ADS_CSS_CLASS = "#tads .ads-ad .ad_cclk"
  BOTTOM_ADS_CSS_CLASS = "#tadsb .ads-ad .ad_cclk"
  RIGHT_ADS_CSS_CLASS = ""
  NON_ADS_CSS_CLASS = ".srg .r"
  TOTAL_RESULT_CSS_CLASS = "#resultStats"

  def initialize keyword = ""
    @query_key_word = keyword.gsub /\s/, "+"
  end

  def perform
    @document = get_document
  end

  private
  def get_document
    @response = open "#{BASE_URL}#{@query_key_word}", "User-Agent" => USER_AGENT
    Nokogiri::HTML @response, nil, ENCODING
  end

  def total_result
    document.at_css(TOTAL_RESULT_CSS_CLASS).text
      .gsub(/[,.]/, '').scan(/\d+/).first
  end

  def non_ads
    document.css NON_ADS_CSS_CLASS
  end

  def top_ads
    document.css TOP_ADS_CSS_CLASS
  end

  def bottom_ads
    document.css BOTTOM_ADS_CSS_CLASS
  end

  def non_ads_links_information links
    {
      size: links.size,
      links: links.map do |link|
        {
          title: link.at_css("h3").content,
          link: link.children.at_css("a").attr("href")
        }
      end
    }
  end

  def ads_links_information links
    {
      size: links.size,
      links: links.map do |link|
        {
          title: link.at_css("h3").content,
          link: link.at_css("cite").content
        }
      end
    }
  end

  def html_code
    document.to_html
  end
end
