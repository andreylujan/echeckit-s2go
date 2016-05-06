
class UnauthorizedController < ApplicationController

  def index
    render nothing: true, status: :unauthorized
  end
end
