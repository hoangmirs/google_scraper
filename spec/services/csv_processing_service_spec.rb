require "rails_helper"

RSpec.describe CsvProcessingService do
  describe ".perform" do
    let(:data) {["iphone", "ruby"]}
    let(:user) {Fabricate :user}
    let(:service) {CsvProcessingService.perform("filename", user.id)}

    it "should call ScrapeWorker without error" do
      allow(CSV).to receive(:read).with("filename", skip_blanks: true){data}
      expect {service}.not_to raise_error
    end
  end
end
