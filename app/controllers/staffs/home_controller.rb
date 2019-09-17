class Staffs::HomeController < ApplicationController
  before_action :authenticate_staff!

  layout 'staffs'

  def index
  end

  def user
    @user = current_staff
  end

  def clients
    @clients = Client.all
  end

  def create_client
    @client = Client.new(client_params)

    if @client.save
      render json: @client, status: :created
    else
      render json: @client.errors, status: :unprocessable_entity
    end
  end

  private

  def client_params
    params.require(:home).permit(:email, :fullname, :phone, :password)
  end
end
