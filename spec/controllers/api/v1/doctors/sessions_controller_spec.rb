require 'rails_helper'
include Api::RequestHelper

RSpec.describe API::V1::Doctors::SessionsController, type: :controller do

	let!(:doctor) { create(:doctor, email: "test@pdmapp.com") }

	before do 
		@request.env["devise.mapping"] = Devise.mappings[:doctor]
	end


	describe 'POST #create' do

		describe "when doctor don't authorized" do
			context "with valid params" do
				before { post :create, params: { doctor: { email: "test@pdmapp.com", password: "password" } } }

				it { expect(response).to be_success }
				it "should return doctor's attributes" do
					expect(response_body["success"]).to eq true
					expect(response_body).to have_key "doctor"
					expect(response_body["doctor"]["id"]).to eq doctor.id
					expect(response_body["doctor"]["email"]).to eq doctor.email
				end
			end

			context "with invalid params" do
				before { post :create, params: { doctor: { email: "test@pdmapp.com", password: "password2" } }, format: :json }

				it { expect(response.status).to be 401 }
				it "should return error" do
					expect(response_body).not_to have_key "doctor"
					expect(response_body["success"]).to eq false
				end
			end
		end

		describe "when doctor authorized" do
			before { sign_in doctor }

			context "with valid params" do
				before { post :create, params: { doctor: { email: "test@pdmapp.com", password: "password" } }, format: :json  }

				it { expect(response.status).to eq 500 }
				it "should return error" do
					expect(response_body["success"]).to eq false
					expect(response_body).not_to have_key "doctor"
					expect(response_body["name"]).to eq "PdmApp::Exceptions::AlreadyAuthorized"

				end
			end

			context "with invalid params" do
				before { post :create, params: { doctor: { email: "test@pdmapp.com", password: "password2" } }, format: :json }
				
				it { expect(response.status).to be 500 }
				it "should return error" do
					expect(response_body).not_to have_key "doctor"
					expect(response_body["success"]).to eq false
				end
			end
		end

	end

	describe 'GET #get_current_user' do
		
		context 'when doctor authorized' do
			before do 
				sign_in doctor
				get :get_current_user, format: :json
			end

			it { expect(response.status).to be 200 }
			it 'should return doctor attributes' do
				expect(response_body["success"]).to eq true
				expect(response_body).to have_key "doctor"
				expect(response_body["doctor"]["id"]).to eq doctor.id
				expect(response_body["doctor"]["email"]).to eq doctor.email
			end
		end

		context 'when doctor dont authorized' do
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
