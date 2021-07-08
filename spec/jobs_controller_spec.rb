require "rails_helper"
require "spec_helper"

RSpec.describe JobsController, type: :controller do
  describe "Jobs API" do

    let!(:user) {FactoryBot.create(:poster)}
    let!(:job) {FactoryBot.create(:job, user: user)}

    let(:headers) do 
    {
      "Authorization" => JsonWebToken.encode(user_id: user.id),
      "Content-Type" => "application/json"
    }
    end

    before do
      request.headers["Authorization"] = headers["Authorization"]
    end

    it "should show all Jobs" do
      get :all_jobs
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)["success"]).to eq(true)
    end

    it "should show a Job" do
      post :show_job, params: { job_id: job.id}
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)["success"]).to eq(true)
    end

    it "should show my Jobs" do
      get :my_jobs
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)["success"]).to eq(true)
    end

    it "should show available Jobs" do
      get :available_jobs
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)["success"]).to eq(true)
    end

    it "should claim a job" do
      post :claim_job, params: { job_id: job.id}
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)["success"]).to eq(true)
    end

    it "should execute a job" do
      post :execute_job, params: { job_id: job.id}
      expect(response).to have_http_status(200)
      expect(JSON.parse(response.body)["success"]).to eq(true)
    end
  end
end