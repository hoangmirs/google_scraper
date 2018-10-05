class Api::V1::ApiController < ActionController::API
  include Pundit
  before_action :doorkeeper_authorize!, :unless => :user_signed_in?

  def current_resource_owner
    User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end

  def pundit_user
    current_resource_owner
  end
end
