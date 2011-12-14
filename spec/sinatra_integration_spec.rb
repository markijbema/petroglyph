require 'ostruct'
require 'sinatra'
require 'petroglyph/tilt'
require 'rack/test'

class PetroglyphApp < Sinatra::Base
  set :root, File.dirname(__FILE__)+"/fixtures"
  get "/" do
    tea = OpenStruct.new(:type => 'tea', :temperature => 'hot')
    coffee = OpenStruct.new(:type => 'coffee', :temperature => 'lukewarm')
    pg :index, :locals => {:drinks => [tea, coffee]}
  end
end

describe "Sinatra integration" do
  include Rack::Test::Methods

  def app
    PetroglyphApp
  end

  it "works" do
    get "/"
    last_response.body.should eq '{"drinks":[{"type":"tea","temperature":"hot"},{"type":"coffee","temperature":"lukewarm"}]}'
  end
end
