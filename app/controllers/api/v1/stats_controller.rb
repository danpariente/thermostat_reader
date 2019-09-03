module Api
  module V1
    class StatsController < BaseController
      def show
        render json: serializer(Stats.new(thermostat))
      end

      private

      def serializer(stats)
        StatsSerializer.new(stats).serialized_json
      end

      def thermostat
        Thermostat.find(params[:thermostat_id])
      end
    end
  end
end
