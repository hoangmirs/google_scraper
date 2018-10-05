require "rails_helper"

RSpec.describe UserAgentRandomService do
  describe ".perform" do
    subject {UserAgentRandomService.perform}

    it "should return a not empty user-agent string" do
      is_expected.to be_a String
      is_expected.not_to be_empty
    end
  end
end
