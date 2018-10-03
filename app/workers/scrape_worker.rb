class ScrapeWorker
  include Sidekiq::Worker
  def perform keyword, user_id
    ScraperService.perform keyword, user_id
  end
end
