class ApplicationController < ActionController::API
    rescue_from ArgumentError, StandardError, :with => :handle_exception

    def handle_exception(e)
        render json: { error: e.message }, status: 400
end
