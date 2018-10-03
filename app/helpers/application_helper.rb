module ApplicationHelper
  def full_title page_title = ""
    base_title = "Google Scraper"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def get_link_type_and_size links, link_type
    "#{link_type.to_s.humanize.pluralize}: #{links.size}"
  end

  def show_sidekiq_running_title
    if (runnung_keywords = Sidekiq::Stats.new.enqueued) > 0
      content_tag :div, class: "alert alert-warning" do
        content_tag :span, "#{runnung_keywords} #{"keyword".pluralize(runnung_keywords)} are being processed"
      end
    end
  end
end
