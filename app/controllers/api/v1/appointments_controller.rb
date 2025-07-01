module Api
  module V1
    class AppointmentsController < ApplicationController
      before_action :set_appointment, only: [ :show, :update, :destroy ]

      def index
        @appointments = Appointment.all
        render json: @appointments
      end

      def show
        render json: @appointment
      end

      def create
        @appointment = Appointment.new(appointment_params)

        return render json: @appointment if @appointment.save

        render json: { errors: @appointment.errors.full_messages }, status: :unprocessable_entity
      end


      def update
        return render json: @appointment if @appointment.update(appointment_params)

        render json: { errors: @appointment.errors.full_messages }, status: :unprocessable_entity
      end

      def destroy
        @appointment.destroy

        render json: :no_content
      end


      private

      def set_appointment
        @appointment = Appointment.find(params[:id])
      end

      def appointment_params
        params.require(:appointment).permit(:psychologist_id, :patient_id, :start_session, :end_session, :status)
      end
    end
  end
end
