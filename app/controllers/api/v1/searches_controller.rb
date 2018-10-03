class Api::V1::SearchesController < Api::V1::ApiController
  def create
    case true
    when params[:keywords_file].present?
      begin
        CsvProcessingService.perform params[:keywords_file].path, current_user.id
        message, status = "The file is being processed", 200
      rescue Exception => e
        message, status = e.message, 400
      end
    when params[:keyword].present?
      search_result = ScraperService.new params[:keyword], current_user.id
      search_result.perform
      if search_result.error.empty?
        message, status = search_result.result.id, 200
      else
        message, status = search_result.error, 400
      end
    else
      message, status = "Invalid request", 400
    end
    render json: {message: message}, status: status
  end
end
