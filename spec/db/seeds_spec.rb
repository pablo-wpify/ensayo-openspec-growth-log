require "rails_helper"

RSpec.describe "db/seeds.rb" do
  let(:seeds_file) { Rails.root.join("db/seeds.rb") }

  before { require Rails.root.join("db/seeds/development").to_s }

  it "does not reach the data-creating part outside development" do
    expect(DevelopmentSeeds).not_to receive(:run)

    load seeds_file
  end

  it "reaches the data-creating part once in development" do
    allow(Rails).to receive(:env).and_return(ActiveSupport::EnvironmentInquirer.new("development"))
    expect(DevelopmentSeeds).to receive(:run).once

    load seeds_file
  end
end
