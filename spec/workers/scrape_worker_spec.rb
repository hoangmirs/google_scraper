require "rails_helper"

RSpec.describe ScrapeWorker do
  describe ".perform" do
    let(:keyword) {"iphone xs"}
    let(:user) {Fabricate :user}

    it "should have a job in queue" do
      expect {
        ScrapeWorker.perform_async(keyword, user.id)
      }.to change(ScrapeWorker.jobs, :size).by(1)
    end
  end
end
