class Staffs::OrganizationsController < ApplicationController
  before_action :authenticate_staff!

  def index
    @organizations = Organization.all
  end

  def create
    @organization = Organization.new(organization_params)

    if @organization.save
      form = Form.find(@organization.form_id)
      render json: {
          id: @organization.id,
          name: @organization.name,
          form: form.form,
          inn: @organization.inn,
          ogrn: @organization.ogrn
      }, status: :created
    else
      render json: @organization.errors, status: :unprocessable_entity
    end
  end

  def show
    @organization = Organization.find(params[:id])
  end

  def update
    @organization ||= Organization.find(params[:id])

    @organization.device_ids = params[:device_id] if params[:device_id]

    if @organization.update(organization_params)
      render json: @organization, status: :ok
    else
      render json: @organization.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @organization = Organization.find(params[:id])

    if @organization.destroy
      render json: "Deleted", status: :accepted
    else
      render json: @organization.errors, status: :unprocessable_entity
    end

  end

  private

  def organization_params
    params.require(:organization).permit(:id, :name, :form_id, :inn, :ogrn)
  end
end
