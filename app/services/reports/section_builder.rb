module Reports
  class SectionBuilder
    attr_reader :name, :date, :rows, :headers

    def initialize(name, date)
      @name = name
      @date = date
      @rows = []
      @headers = []
    end

    def columns(*cols)
      @headers = cols.map(&:to_s)
    end

    def row(*values)
      @rows << values
    end

    def rows
      @rows.to_enum
    end

    def appointments_summary
      scope = Appointment.where(start_session: date.beginning_of_month..date.end_of_month)

      total_by_status = scope.group(:status).count
      row("Resumo por status")
      total_by_status.each { |status, count| row(status, count) }

      row()

      total_by_psychologist = scope.group(:psychologist_id).count
      row("Resumo por psicólogo")
      total_by_psychologist.each do |psych_id, count|
        email = User.find(psych_id).email
        row(email, count)
      end

      columns(:label, :total)
    end

    def payments_summary
      scope = Payment.where(created_at: date.beginning_of_month..date.end_of_month)
      total_by_status = scope.group(:status).sum(:amount)

      row("Resumo de pagamentos")
      total_by_status.each { |status, total| row(status, total) }

      columns(:status, :total_amount)
    end
  end
end
