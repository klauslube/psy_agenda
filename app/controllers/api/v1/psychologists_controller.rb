module Api
  module V1
    class PsychologistsController < ApplicationController
      def available_appointments
        psychologist = User.find(params[:id])
        date = params[:date] || Date.today

        appointments = AvailableAppointmentsQuery.new(psychologist: psychologist, date: date).call
        render json: appointments
      end
    end
  end
end
