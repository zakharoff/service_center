class Staffs::HomeController < ApplicationController
  before_action :authenticate_staff!

  layout 'staffs'

  def index
  end

  def user
    @user = current_staff
  end
end
