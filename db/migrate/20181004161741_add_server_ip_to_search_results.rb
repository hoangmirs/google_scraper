class AddServerIpToSearchResults < ActiveRecord::Migration[5.1]
  def change
    add_column :search_results, :server_ip, :string, null: false
    add_column :search_results, :user_agent, :string, null: false
  end
end
