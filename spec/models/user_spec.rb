require "rails_helper"

RSpec.describe User, type: :model do
  describe "relationships" do
    subject {Fabricate.build(:user)}
    it {is_expected.to have_many(:search_results).dependent :destroy}
    it {is_expected.to have_many(:access_grants).dependent :delete_all}
    it {is_expected.to have_many(:access_tokens).dependent :delete_all}
  end

  describe "validations" do
    subject {Fabricate.build(:user)}

    it {is_expected.to validate_presence_of(:email)}
    it {is_expected.to validate_presence_of(:password)}
  end

  describe ".from_omniauth" do
    let(:auth_hash) do
      {
        provider: "google_oauth2",
        uid: "100000000000000000000",
        info: {
          name: "John Smith",
          email: "john@example.com",
          first_name: "John",
          last_name: "Smith"
        }.stringify_keys
      }.stringify_keys
    end

    context "when new user" do
      it "should create a new user" do
        expect {User.from_omniauth(auth_hash)}.to change(User, :count).by(1)
      end
    end

    context "when exist user" do
      before :each do
        Fabricate.create :user, email: "john@example.com"
      end

      it "should raise exception" do
        expect {User.from_omniauth(auth_hash)}.to raise_error(ActiveRecord::RecordInvalid)
      end
    end
  end
end
