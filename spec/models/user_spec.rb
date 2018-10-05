require 'rails_helper'

RSpec.describe User, type: :model do
  describe "relationships" do
    it {is_expected.to have_many(:search_results).dependent :destroy}
    it {is_expected.to have_many(:access_grants).dependent :delete_all}
    it {is_expected.to have_many(:access_tokens).dependent :delete_all}
  end
  describe "validations" do
    it {is_expected.to validate_presence_of(:email)}
    it {is_expected.to validate_presence_of(:password)}
  end
end
