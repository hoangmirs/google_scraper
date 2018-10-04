class Api::V1::SearchResultsController < Api::V1::ApiController
  before_action :load_search_results, only: :index
  before_action :load_search_result, only: :show

  def index
    render json: @search_results
  end

  def show
    render json: @search_result, detail: true
  end

  private
  def load_search_results
    @search_results = SearchResult.includes(:user).order(:keyword).page(params[:page]).per(Settings.pagination.per_page)
  end

  def load_search_result
    @search_result = SearchResult.includes(:user, :links).find_by id: params[:id]
  end
end
