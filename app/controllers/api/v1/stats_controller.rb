module Api
  module V1
    class StatsController < BaseController
      def show
        render json: serializer(stats)
      end

      private

      def serializer(stats)
        StatsSerializer.new(stats).serialized_json
      end

      def stats
        Stats.find(params[:thermostat_id])
      end
    end
  end
end
