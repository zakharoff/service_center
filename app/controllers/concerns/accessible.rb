module Accessible
  extend ActiveSupport::Concern
  included do
    before_action :check_user
  end

  protected
  def check_user
    if current_staff
      flash.clear
      redirect_to(staffs_home_index_path) && return
    elsif current_client
      flash.clear
      redirect_to(clients_home_index_path) && return
    end
  end
end
