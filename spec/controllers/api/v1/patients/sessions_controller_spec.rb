require 'rails_helper'
include Api::RequestHelper

RSpec.describe Api::V1::Patients::SessionsController, type: :controller do

	let!(:patient) { create(:patient, email: "test@pdmapp.com") }

	before do 
		@request.env["devise.mapping"] = Devise.mappings[:patient]
	end


	describe 'POST #create' do

		describe "when patient don't authorized" do
			context "with valid params" do
				before { post :create, params: { patient: { email: "test@pdmapp.com", password: "password" } } }

				it { expect(response).to be_success }
				it "should return patient's attributes" do
					expect(response_body["success"]).to eq true
					expect(response_body).to have_key "patient"
					expect(response_body["patient"]["id"]).to eq patient.id
					expect(response_body["patient"]["email"]).to eq patient.email
				end
			end

			context "with invalid params" do
				before { post :create, params: { patient: { email: "test@pdmapp.com", password: "password2" } }, format: :json }

				it { expect(response.status).to be 401 }
				it "should return error" do
					expect(response_body).not_to have_key "patient"
					expect(response_body["success"]).to eq false
				end
			end
		end

		describe "when patient authorized" do
			before { sign_in patient }

			context "with valid params" do
				before { post :create, params: { patient: { email: "test@pdmapp.com", password: "password" } }, format: :json  }

				it { expect(response.status).to eq 500 }
				it "should return error" do
					expect(response_body["success"]).to eq false
					expect(response_body).not_to have_key "patient"
					expect(response_body["name"]).to eq "PdmApp::Exceptions::AlreadyAuthorized"

				end
			end

			context "with invalid params" do
				before { post :create, params: { patient: { email: "test@pdmapp.com", password: "password2" } }, format: :json }
				
				it { expect(response.status).to be 500 }
				it "should return error" do
					expect(response_body).not_to have_key "patient"
					expect(response_body["success"]).to eq false
				end
			end
		end

	end

	describe 'GET #get_current_user' do
		
		context 'when patient authorized' do
			before do 
				sign_in patient
				get :get_current_user, format: :json
			end

			it { expect(response.status).to be 200 }
			it 'should return patient attributes' do
				expect(response_body["success"]).to eq true
				expect(response_body).to have_key "patient"
				expect(response_body["patient"]["id"]).to eq patient.id
				expect(response_body["patient"]["email"]).to eq patient.email
			end
		end

		context 'when patient dont authorized' do
			before { get :get_current_user, format: :json }

			it { expect(response.status).to be 401 }
			it 'should return error' do
				expect(response_body["success"]).to eq false 
				expect(response_body["name"]).to eq "PdmApp::Exceptions::NotAuthorized"
			end
		end
	end

	describe "DELETE #destroy" do
		before { delete :destroy, format: :json }

		it { expect(response.status).to be 200 }
		it { expect(response_body["success"]).to be true }
	end

end
