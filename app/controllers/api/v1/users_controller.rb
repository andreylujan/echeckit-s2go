class Api::V1::UsersController < ApplicationController

    before_action :doorkeeper_authorize!
    
end
