require 'rails_helper'

RSpec.describe SearchResult, type: :model do
  describe "relationships" do
    it {is_expected.to belong_to(:user)}
    it {is_expected.to have_many(:links).dependent :destroy}
  end
  describe "validations" do
    subject { Fabricate.build(:search_result) }
    it {is_expected.to validate_presence_of(:keyword)}
    it {is_expected.to validate_uniqueness_of(:keyword)}
    it {is_expected.to validate_presence_of(:total_results)}
    it {is_expected.to validate_presence_of(:total_links)}
    it {is_expected.to validate_presence_of(:html_code)}
    it {is_expected.to validate_presence_of(:server_ip)}
    it {is_expected.to validate_presence_of(:user_agent)}
  end
end
