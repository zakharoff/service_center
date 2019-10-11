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

  def show
    @staff = Staff.find(params[:id])
  end

  def update
    @staff ||= Staff.find(params[:id])

    if @staff.update(staff_params)
      render json: @staff, status: :ok
    else
      render json: @staff.errors, status: :unprocessable_entity
    end
  end

  def reset_password
    new_password = params[:newPassword]
    @staff = Staff.find(params[:id])

    if @staff.reset_password(new_password, new_password)
      render json: @staff, status: :ok
    else
      render json: @staff.errors, status: :unprocessable_entity
    end
  end

  private

  def staff_params
    params.permit(:email, :password)
  end
end
