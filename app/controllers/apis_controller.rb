class ApisController < ApplicationController
  skip_before_action :verify_authentication

  def index
  end
end