module Api
  module V1
    class ReadingsController < BaseController
      def show
        render json: serializer(reading)
      end

      def create
        reading = thermostat.readings.new(reading_params)

        if reading.valid?
          collect_data_from_thermostat
          render json: serializer(reading), status: :created
        else
          render json: errors(reading), status: :unprocessable_entity
        end
      end

      private

      def reading
        thermostat.readings.find_by!(tracking_number: params[:tracking_number])
      end

      def thermostat
        Thermostat.find(params[:thermostat_id])
      end

      def collect_data_from_thermostat
        ThermostatDataJob.collect(thermostat, reading_params)
      end

      def serializer(reading)
        ReadingSerializer.new(reading).serialized_json
      end

      def errors(reading)
        {
          errors: {
            title: "UnprocessableEntity",
            detail: reading.errors.full_messages.join(", ")
          }
        }
      end

      def reading_params
        params.require(:reading).
          permit(:temperature, :humidity, :battery_charge)
      end
    end
  end
end
