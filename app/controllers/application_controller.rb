class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: %i[index new create destroy]

  def index
  end
end
