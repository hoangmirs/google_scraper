require "rails_helper"

RSpec.describe LinksQuery do
  describe ".adwords" do
    before(:each) do
      user = Fabricate.create :user
      search_result = Fabricate.create :search_result, user: user
      Fabricate :link, link_type: "non_ad", search_result: search_result
      Fabricate :link, link_type: "top_ad", search_result: search_result
      Fabricate :link, link_type: "bottom_ad", search_result: search_result
    end
    it "should return 2 links adwords" do
      expect(LinksQuery.new.adwords.count).to eq(2)
    end

    it "should return 1 link non-ad" do
      expect(LinksQuery.new.relation.count - LinksQuery.new.adwords.count).to eq(1)
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
      expect(LinksQuery.new.adword_url_contains("iphone").count).to eq(2)
    end

    it "should return 1 link adwords contains 'iphone-x'" do
      expect(LinksQuery.new.adword_url_contains("iphone-x").count).to eq(1)
    end

    it "should return 0 link adwords contains 'iphone-8'" do
      expect(LinksQuery.new.adword_url_contains("iphone-8").count).to eq(0)
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
      expect(LinksQuery.new.specific_url("https://news.com/").count).to eq(3)
    end

    it "should return 1 link 'https://news.com/iphone-8-plus-hot'" do
      expect(LinksQuery.new.specific_url("https://news.com/iphone-8-plus-hot").count).to eq(1)
    end

    it "should return 0 link 'https://news.com/iphone-8-plus-hot-trend'" do
      expect(LinksQuery.new.specific_url("https://news.com/iphone-8-plus-hot-trend").count).to eq(0)
    end
  end

  describe ".string_occurs" do
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

    it "should return 3 links with '2+-'" do
      expect(LinksQuery.new.string_occurs("2+-").count).to eq(3)
    end

    it "should return 2 links with '3+-'" do
      expect(LinksQuery.new.string_occurs("3+-").count).to eq(2)
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
        expect(LinksQuery.new.query("adword_url_contains", "iphone").count).to eq(2)
      end

      it "should return 1 link adwords contains 'iphone-x'" do
        expect(LinksQuery.new.query("adword_url_contains", "iphone-x").count).to eq(1)
      end

      it "should return 0 link adwords contains 'iphone-8'" do
        expect(LinksQuery.new.query("adword_url_contains", "iphone-8").count).to eq(0)
      end
    end

    context "when call with query_type 'specific_url'" do
      it "should return 3 links 'https://news.com/" do
        expect(LinksQuery.new.query("specific_url", "https://news.com/").count).to eq(3)
      end

      it "should return 1 link 'https://news.com/iphone-8-plus-hot'" do
        expect(LinksQuery.new.query("specific_url", "https://news.com/iphone-8-plus-hot").count).to eq(1)
      end

      it "should return 0 link 'https://news.com/iphone-8-plus-hot-trend'" do
        expect(LinksQuery.new.query("specific_url", "https://news.com/iphone-8-plus-hot-trend").count).to eq(0)
      end
    end

    context "when call with query_type 'string_occurs'" do
      it "should return 3 links with '2+-'" do
        expect(LinksQuery.new.query("string_occurs", "2+-").count).to eq(3)
      end

      it "should return 2 links with '3+-'" do
        expect(LinksQuery.new.query("string_occurs", "3+-").count).to eq(2)
      end
    end
  end
end
