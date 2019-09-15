json.user do
  json.email @user.email
  json.exit_link url_for(destroy_staff_session_path)
end
