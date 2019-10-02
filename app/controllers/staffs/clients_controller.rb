class Staffs::ClientsController < ApplicationController
  before_action :authenticate_staff!

  def index
    @clients = Client.all
  end

  def create
    @client = Client.new(client_params)

    if @client.save
      render json: @client, status: :created
    else
      render json: @client.errors, status: :unprocessable_entity
    end
  end

  def show
    @client = Client.find(params[:id])
  end

  def update
    @client ||= Client.find(params[:id])

    if @client.update(client_params)
      render json: @client, status: :ok
    else
      render json: @client.errors, status: :unprocessable_entity
    end
  end

  def reset_password
    new_password = params[:newPassword]
    @client = Client.find(params[:id])

    if @client.reset_password(new_password, new_password)
      render json: @client, status: :ok
    else
      render json: @client.errors, status: :unprocessable_entity
    end
  end

  private

  def client_params
    params.permit(:email, :fullname, :phone, :password)
  end
end
