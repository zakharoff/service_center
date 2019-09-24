class Staffs::FormsController < ApplicationController
  before_action :authenticate_staff!

  def index
    @forms = Form.all
  end
end
