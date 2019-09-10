module Api
  module V1
    class BaseController < ApplicationController
      prepend_before_action :authorize
      rescue_from ActiveRecord::RecordNotFound, with: :not_found

      def authorize
        unless Thermostat.exists?(household_token: authorization_token)
          render json: {
            errors: {
              title: "Unauthorized",
              detail: "Unauthorized."
            }
          }, status: :unauthorized
        end
      end

      private

      def authorization_token
        @authorization_token ||= authorization_header
      end

      def authorization_header
        request.headers["thermostat-auth-token"]
      end

      def not_found
        render json: {
          errors: {
            title: "RecordNotFound",
            detail: "Record not found."
          }
        }, status: :not_found
      end
    end
  end
end
