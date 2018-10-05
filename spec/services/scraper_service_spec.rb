require "rails_helper"

RSpec.describe ScraperService do
  describe ".perform" do
    let(:keyword) {"iphone xs"}
    let(:user) {Fabricate :user}
    let(:service) {ScraperService.new(keyword, user.id)}

    context "when using valid keyword" do
      it "should create SearchResult if perform success" do
        VCR.use_cassette("scraper_service", record: :all) do
          expect {service.perform}.to change(SearchResult, :count).by(1)
        end
      end
    end

    context "when using duplicate keyword" do
      it "should not create SearchResult" do
        VCR.use_cassette("scraper_service", record: :all) do
          ScraperService.perform(keyword, user.id)
          expect {service.perform}.to change(SearchResult, :count).by(0)
        end
      end
    end

    context "when using invalid encoding keyword" do
      let(:keyword) {"du lịch"}
      it "should create SearchResult" do
        VCR.use_cassette("scraper_service", record: :all) do
          expect {service.perform}.to change(SearchResult, :count).by(1)
        end
      end
    end
  end
end
