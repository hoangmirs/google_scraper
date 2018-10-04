class Api::V1::LinkQueriesController < Api::V1::ApiController
  before_action :check_param_type, :check_param_keyword
  def index
    render json: Link.includes(:search_result).query(params[:type], params[:keyword])
  end

  private
  def check_param_type
    return if ["adword_url_contains", "specific_url"].include? params[:type]
    render json: {message: "Invalid type"}, status: 400
  end

  def check_param_keyword
    return if params[:keyword].present?
    render json: {message: "Empty keyword"}, status: 400
  end
end
