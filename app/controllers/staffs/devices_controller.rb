class Staffs::DevicesController < ApplicationController
  before_action :authenticate_staff!

  def index
    @devices = Device.all
  end
end
