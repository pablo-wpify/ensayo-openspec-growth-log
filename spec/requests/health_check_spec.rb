require "rails_helper"

RSpec.describe "Health check", type: :request do
  it "responds 200 on GET /up" do
    get "/up"

    expect(response).to have_http_status(:ok)
  end
end
