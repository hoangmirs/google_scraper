class SearchResultsController < ApplicationController
  before_action :load_search_result, except: :index

  def index
    @search_results = policy_scope(SearchResult).includes(:user).order(:keyword).page(params[:page]).per(Settings.pagination.per_page).decorate
  end

  def show
  end

  def new
  end

  def destroy
    if @search_result.destroy
      flash[:success] = "Delete successful"
    else
      flash[:danger] = "Delete failed"
    end
    redirect_to search_results_path
  end

  private
  def load_search_result
    @search_result = policy_scope(SearchResult).find_by(id: params[:id])&.decorate
  end
end
