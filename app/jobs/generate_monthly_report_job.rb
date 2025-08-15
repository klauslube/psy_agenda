class GenerateMonthlyReportJob < ApplicationJob
  queue_as :default
  require "csv"

  def perform(date = Date.current)
    report = Reports::MonthlyReport.generate(date) do
      section "Agendamentos" do
        appointments_summary
      end

      section "Pagamentos" do
        payments_summary
      end
    end

    file_path = Rails.root.join("tmp", "monthly_report.csv")

    CSV.open(file_path, "w") do |csv|
      lines = Enumerator.new do |y|
        report.sections.each do |section|
          y << [ "Seção: #{section.name}" ]
          y << section.headers
          section.rows.each { |row| y << row }
          y << []
        end
      end.lazy

      lines.each { |line| csv << line }
    end

    puts "Relatório gerado em lazy: #{file_path}"
  end
end
