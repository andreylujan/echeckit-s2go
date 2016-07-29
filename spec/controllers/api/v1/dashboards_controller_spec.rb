# -*- encoding : utf-8 -*-
require 'rails_helper'

RSpec.describe Api::V1::DashboardsController, type: :controller do

  describe "GET #sales" do
    it "returns http success" do
      get :sales
      expect(response).to have_http_status(:success)
    end
  end

end
