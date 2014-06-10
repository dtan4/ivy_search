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
  end
end
