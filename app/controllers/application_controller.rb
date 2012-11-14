class ApplicationController < ActionController::Base
  protect_from_forgery
  before_filter :authenticate_user!
  respond_to :json

  skip_before_filter :verify_authenticity_token, if: Proc.new { |c| c.request.format == 'application/json' }

  rescue_from ActiveRecord::RecordNotFound, with: :not_found
  rescue_from StandardError, with: :standard_error

  private
  def not_found
    render "errors/not_found", status: 404 and return
  end

  def standard_error
    render "errors/standard_error", status: 500 and return
  end

  def invalid_resource!(resource)
    @resource = resource
    render "errors/invalid_resource", status: 422
  end
end
