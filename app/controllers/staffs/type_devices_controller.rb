class Staffs::TypeDevicesController < ApplicationController
  before_action :authenticate_staff!

  def index
    @type_devices = TypeDevice.all
  end
end
