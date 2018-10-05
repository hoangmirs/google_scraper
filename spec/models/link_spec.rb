require "rails_helper"

RSpec.describe Link, type: :model do
  describe "relationships" do
    it {is_expected.to belong_to(:search_result)}
  end

  describe "validations" do
    it {is_expected.to validate_presence_of(:link_type)}
    it {is_expected.to validate_presence_of(:title)}
    it {is_expected.to validate_presence_of(:url)}
  end

  describe ".adwords" do
    before(:each) do
      user = Fabricate.create :user
      search_result = Fabricate.create :search_result, user: user
      Fabricate :link, link_type: "non_ad", search_result: search_result
      Fabricate :link, link_type: "top_ad", search_result: search_result
      Fabricate :link, link_type: "bottom_ad", search_result: search_result
    end
    it "should return 2 links adwords" do
      expect(Link.adwords.count).to eq(2)
    end

    it "should return 1 link non-ad" do
      expect(Link.all.count - Link.adwords.count).to eq(1)
    end
  end

  describe ".adword_url_contains" do
    before(:each) do
      user = Fabricate.create :user
      search_result = Fabricate.create :search_result, user: user
      Fabricate :link, link_type: "non_ad", search_result: search_result,
        url: "https://news.com/iphone-8-plus-hot"
      Fabricate :link, link_type: "top_ad", search_result: search_result,
        url: "https://news.com/iphone-xs-introduction"
      Fabricate :link, link_type: "bottom_ad", search_result: search_result,
        url: "https://news.com/iphone-5-has-died"
    end

    it "should return 2 links adwords contains 'iphone'" do
      expect(Link.adword_url_contains("iphone").count).to eq(2)
    end

    it "should return 1 link adwords contains 'iphone-x'" do
      expect(Link.adword_url_contains("iphone-x").count).to eq(1)
    end

    it "should return 0 link adwords contains 'iphone-8'" do
      expect(Link.adword_url_contains("iphone-8").count).to eq(0)
    end
  end

  describe ".specific_url" do
    before(:each) do
      user = Fabricate.create :user
      search_result = Fabricate.create :search_result, user: user
      Fabricate :link, link_type: "non_ad", search_result: search_result,
        url: "https://news.com/iphone-8-plus-hot"
      Fabricate :link, link_type: "top_ad", search_result: search_result,
        url: "https://news.com/iphone-xs-introduction"
      Fabricate :link, link_type: "bottom_ad", search_result: search_result,
        url: "https://news.com/iphone-5-has-died"
    end

    it "should return 3 links 'https://news.com/" do
      expect(Link.specific_url("https://news.com/").count).to eq(3)
    end

    it "should return 1 link 'https://news.com/iphone-8-plus-hot'" do
      expect(Link.specific_url("https://news.com/iphone-8-plus-hot").count).to eq(1)
    end

    it "should return 0 link 'https://news.com/iphone-8-plus-hot-trend'" do
      expect(Link.specific_url("https://news.com/iphone-8-plus-hot-trend").count).to eq(0)
    end
  end

  describe ".query" do
    before(:each) do
      user = Fabricate.create :user
      search_result = Fabricate.create :search_result, user: user
      Fabricate :link, link_type: "non_ad", search_result: search_result,
        url: "https://news.com/iphone-8-plus-hot"
      Fabricate :link, link_type: "top_ad", search_result: search_result,
        url: "https://news.com/iphone-xs-introduction"
      Fabricate :link, link_type: "bottom_ad", search_result: search_result,
        url: "https://news.com/iphone-5-has-died"
    end

    context "when call with query_type 'adword_url_contains'" do
      it "should return 2 links adwords contains 'iphone'" do
        expect(Link.query("adword_url_contains", "iphone").count).to eq(2)
      end

      it "should return 1 link adwords contains 'iphone-x'" do
        expect(Link.query("adword_url_contains", "iphone-x").count).to eq(1)
      end

      it "should return 0 link adwords contains 'iphone-8'" do
        expect(Link.query("adword_url_contains", "iphone-8").count).to eq(0)
      end
    end

    context "when call with query_type 'specific_url'" do
      it "should return 3 links 'https://news.com/" do
        expect(Link.query("specific_url", "https://news.com/").count).to eq(3)
      end

      it "should return 1 link 'https://news.com/iphone-8-plus-hot'" do
        expect(Link.query("specific_url", "https://news.com/iphone-8-plus-hot").count).to eq(1)
      end

      it "should return 0 link 'https://news.com/iphone-8-plus-hot-trend'" do
        expect(Link.query("specific_url", "https://news.com/iphone-8-plus-hot-trend").count).to eq(0)
      end
    end
  end
end
