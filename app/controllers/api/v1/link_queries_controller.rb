class Api::V1::LinkQueriesController < Api::V1::ApiController
  before_action :check_param_type, :check_param_keyword
  def index
    render json: load_links
  end

  private
  def check_param_type
    return if ["adword_url_contains", "specific_url", "string_occurs"].include? params[:type]
    render json: {message: "Invalid type"}, status: 400
  end

  def check_param_keyword
    return if params[:keyword].present?
    render json: {message: "Empty keyword"}, status: 400
  end

  def load_links
    LinksQuery.new.query params[:type], params[:keyword]
  end
end
