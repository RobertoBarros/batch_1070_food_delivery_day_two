require 'digest'
require_relative '../views/sessions_view'

class SessionsController

  def initialize(employee_repository)
    @employee_repository = employee_repository
    @view = SessionsView.new
  end

  def login
    username = @view.ask_username
    password = Digest::SHA1.hexdigest(@view.ask_password)

    employee = @employee_repository.find_by_username(username)

    if employee && employee.password == password
      @view.welcome(username)
    else
      @view.wrong_credentials
      login
    end
    employee
  end

end
