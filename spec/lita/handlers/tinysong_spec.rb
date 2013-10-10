require 'spec_helper'

describe Lita::Handlers::Tinysong, lita_handler: true do
  it { routes_command("groove me the final countdown").to :groove }
  it { routes_command("groove last night a dj saved my life").to :groove }

  describe "#groove" do
    context "when no API key is set" do
      it "complains loudly" do
        send_command("groove me whatever you feel like, buddy")
        expect(replies.last).to include("Tinysong API key required")
      end
    end

    context "when an API key is set" do
      before do 
        Lita.config.handlers.tinysong.api_key = 'a_fake_api_key'
      end
      context "when a song is found" do
        let(:body) { "http:\/\/tinysong.com\/gHQJ" }
        before do
          allow_any_instance_of(Faraday::Connection).to receive(:get).and_return(double("Faraday::Response", status: 200, body: body))
        end
        it "replies with a link to the song" do
          send_command("groove gut feeling")
          expect(replies.last).to include("http:\/\/tinysong.com\/gHQJ")
        end
      end

      context "when no song is found" do
        let(:body) { "[]" }
        before do
          allow_any_instance_of(Faraday::Connection).to receive(:get).and_return(double("Faraday::Response", status: 200, body: body))
        end
        it "is apologetic" do
          send_command("groove me dog police where are you coming from") 
          expect(replies.last).to include("I couldn't find any results for 'dog police where are you coming from'!")
        end
      end
    end
  end
end
