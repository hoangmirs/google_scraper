require 'rails_helper'

RSpec.describe Link, type: :model do
  describe "relationships" do
    it {is_expected.to belong_to(:search_result)}
  end
  describe "validations" do
    it {is_expected.to validate_presence_of(:link_type)}
    it {is_expected.to validate_presence_of(:title)}
    it {is_expected.to validate_presence_of(:url)}
  end
end
