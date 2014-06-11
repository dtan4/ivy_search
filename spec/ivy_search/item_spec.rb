require "spec_helper"

module IvySearch
  describe Item do
    let(:id) do
      "id"
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
      subject(:item) do
        described_class.new(args)
      end

      context "when nil is given" do
        let(:args) do
          nil
        end

        it { expect(item).to be_a described_class }
      end

      context "when some arguments are given" do
        let(:args) do
          {
           id: id,
           title: title
          }
        end

        it { expect(item).to be_a described_class }
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
