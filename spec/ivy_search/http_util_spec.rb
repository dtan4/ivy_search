require "spec_helper"

describe IvySearch::HttpUtil do
  class DummyClass
    include IvySearch::HttpUtil
  end

  let(:klass) do
    DummyClass.new
  end

  let(:url) do
    "http://example.com/"
  end

  describe "#fetch_web_page" do
    subject(:fetch) do
      klass.fetch_web_page(arg)
    end

    context "when nil is given" do
      let(:arg) do
        nil
      end

      it "should raise ArgumentError" do
        expect { fetch }.to raise_error ArgumentError
      end
    end

    context "when a valid URL is given" do
      let(:arg) do
        url
      end

      before do
        stub_request(:get, url).to_return(status: 200, body: open(fixture_path("item.html")).read)
      end

      it "should return a instance of Nokogiri::HTML::Document" do
        expect(fetch).to be_a Nokogiri::HTML::Document
      end
    end

    context "when a invalid URL is given" do
      let(:arg) do
        url
      end

      before do
        stub_request(:get, url).to_return(status: 404)
      end

      it "should raise IvySearch::HttpError" do
        expect { fetch }.to raise_error IvySearch::HttpError
      end
    end
  end
end
