require 'rails_helper'

RSpec.describe API::V1::Doctors::SessionsController, type: :controller do

	describe 'POST #create' do
		let!(:user) { create(:doctor, email: "test@pdmapp.com") }

		context "when doctor don't authorized" do

			it "responds successfully with an HTTP 200 status code" do
				@request.env["devise.mapping"] = Devise.mappings[:doctor]
				post :create, { format: :json, doctor: { email: "test@pdmapp.com", password: "password" } }

				binding.pry
				expect(response).to be_success
			end

		end

	end

end
