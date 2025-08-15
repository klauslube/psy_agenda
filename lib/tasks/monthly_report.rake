namespace :reports do
  desc "Gera o relatório mensal em CSV (síncrono)"
  task :monthly_csv, [ :year, :month ] => :environment do |t, args|
    require "csv"

    year = args[:year]&.to_i || Date.today.year
    month = args[:month]&.to_i || Date.today.month
    date = Date.new(year, month, 1)

    report = Reports::MonthlyReport.generate(date) do
      section "Agendamentos" do
        appointments_summary
      end

      section "Pagamentos" do
        payments_summary
      end
    end

    filename = "monthly_report_#{year}_#{month}.csv"
    filepath = Rails.root.join("tmp", filename)

    File.write(filepath, report.to_csv)
    puts "Relatório gerado em: #{filepath}"
  end

  desc "Gera relatório mensal em background (ActiveJob)"
  task monthly_async: :environment do
    GenerateMonthlyReportJob.perform_later(Date.current)
    puts "Job enfileirado"
  end
end
