class CsvProcessingService < BaseService
  def initialize file_path, user_id
    @file_path = file_path
    @user_id = user_id
  end

  def perform
    keywords = CSV.read(@file_path, skip_blanks: true).flatten
    keywords.each do |keyword|
      ScrapeWorker.perform_async keyword, @user_id
    end
  end
end
