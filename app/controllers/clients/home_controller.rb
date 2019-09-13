class Clients::HomeController < ApplicationController
  before_action :authenticate_client!

  layout 'clients'

  def index
  end
end
