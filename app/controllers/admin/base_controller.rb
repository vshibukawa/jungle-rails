class Admin::BaseController < ApplicationController
  http_basic_authenticate_with name: ENV['ADMIN_USERNAME'].to_s, password: ENV['ADMIN_PASSWORD'].to_s
  # before_action :authorize

  # def authorize
  #   authenticate_or_request_with_http_basic do |user, password|
  #     if user == ENV['ADMIN_USERNAME'] && password == ENV['ADMIN_PASSWORD']
  #       true
  #     end
  #   end
  # end
end

# class Admin::BaseController < ApplicationController::Base
#   http_basic_authenticate_with name: ENV['ADMIN_USERNAME'].to_s, password: ENV['ADMIN_PASSWORD'].to_s
# end