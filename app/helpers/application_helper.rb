module ApplicationHelper
  def full_title page_title = ""
    base_title = "Google Scraper"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def get_link_type_and_size links
    "#{links.last.link_type.humanize}: #{links.size}"
  end
end
