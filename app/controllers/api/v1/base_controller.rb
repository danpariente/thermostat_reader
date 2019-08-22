module Api
  module V1
    class BaseController < ApplicationController
      rescue_from ActiveRecord::RecordNotFound, with: :not_found

      private

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
