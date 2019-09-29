class Staffs::StaffsController < ApplicationController
  before_action :authenticate_staff!

  def index
    @staffs = Staff.all
  end

  def create
    @staff = Staff.new(staff_params)

    if @staff.save
      render json: @staff, status: :created
    else
      render json: @staff.errors, status: :unprocessable_entity
    end
  end

  private

  def staff_params
    params.permit(:email, :password)
  end
end
