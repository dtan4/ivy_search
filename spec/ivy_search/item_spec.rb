require "spec_helper"

module IvySearch
  describe Item do
    let(:item) do
      described_class.new(id: id, title: title, artist: artist, genres: genres)
    end

    let(:id) do
      "123456789"
    end

    let(:title) do
      "title"
    end

    let(:artist) do
      "artist"
    end

    let(:genres) do
      ["pop", "jazz"]
    end

    let(:item) do
      described_class.new(id: id, title: title, artist: artist, genres: genres)
    end

    describe "#initialize" do
      subject(:init) do
        described_class.new(args)
      end

      context "when nil is given" do
        let(:args) do
          nil
        end

        it { expect(init).to be_a described_class }
      end

      context "when some arguments are given" do
        let(:args) do
          {
           id: id,
           title: title
          }
        end

        it { expect(init).to be_a described_class }
      end
    end

    describe "#check_stock" do
      subject(:check) do
        item.check_stock(arg)
      end

      context "when nil is given" do
        let(:arg) do
          nil
        end

        it "should raise ArgumentError" do
          expect { subject }.to raise_error ArgumentError
        end
      end

      context "when shop id is given" do
        let(:arg) do
          "2312"
        end

        context "and this item is available" do

          before do
            stub_request(:get, "http://store.tsutaya.co.jp/item/rental_cd/#{id}.html?storeId=#{arg}")
              .to_return(status: 200, body: open(fixture_path("item_stock_available.html")).read)
          end

          it "should return 'o'" do
            expect(subject).to eq "o"
          end
        end

        context "and this item is on loan" do
          before do
            stub_request(:get, "http://store.tsutaya.co.jp/item/rental_cd/#{id}.html?storeId=#{arg}")
              .to_return(status: 200, body: open(fixture_path("item_stock_onloan.html")).read)
          end

          it "should return 'x'" do
            expect(subject).to eq "x"
          end
        end

        context "and this item is unavailable" do
          before do
            stub_request(:get, "http://store.tsutaya.co.jp/item/rental_cd/#{id}.html?storeId=#{arg}")
              .to_return(status: 200, body: open(fixture_path("item_stock_unavailable.html")).read)
          end

          it "should return '-'" do
            expect(subject).to eq "-"
          end
        end
      end
    end

    describe "#id" do
      it "should return id" do
        expect(item.id).to eq id
      end
    end

    describe "#title" do
      it "should return title" do
        expect(item.title).to eq title
      end
    end

    describe "#artist" do
      it "should return artist" do
        expect(item.artist).to eq artist
      end
    end

    describe "#genres" do
      it "should return genres" do
        expect(item.genres).to match_array genres
      end
    end
  end
end
