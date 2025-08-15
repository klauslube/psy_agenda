module Reports
  class MonthlyReport
    attr_reader :sections

    def initialize(date)
      @date = date
      @sections = []
    end

    def self.generate(date, &block)
      report = new(date)
      report.instance_eval(&block) if block_given?
      report
    end

    def section(name, &block)
      builder = SectionBuilder.new(name, @date)
      builder.instance_eval(&block) if block_given?
      @sections << builder
    end

    def to_csv
      CSV.generate(headers: true) do |csv|
        @sections.each do |section|
          csv << [ section.name ]
          csv << section.headers
          section.rows.each { |row| csv << row }
          csv << []
        end
      end
    end
  end
end
