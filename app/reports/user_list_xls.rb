class UserListXls
  attr_accessor :survey
  
  CELL_TYPE = {
    :float => Spreadsheet::Format.new( :number_format => '0.00' ),
    :percent => Spreadsheet::Format.new( :number_format => '0.00%' ),
  }

  FORMAT = {
    :header => Spreadsheet::Format.new(
       :bold => true,
       :horizontal_align => :center,
       :size => 11
    )
  }


  def initialize
    @workbook = Spreadsheet::Workbook.new
  end

  def generate_data_sheet
    worksheet = @workbook.create_worksheet(:name => 'e.mote data')
    0.upto(10) { |i| worksheet.column(i).width = 30 }
    worksheet.column(0).width = worksheet.column(7).width = worksheet.column(8).width = 8
    @current_row_index = 0

    header =[
      'ID',
      'Email',
      'Name',
      'Title',
      'Company',
      'Login count',
      'Last login',
      'eMotes',
      'Plan',
      'Partner code'
    ]
    insert_styled_row(worksheet, @current_row_index, header, :header)


    User.all.each do |user|
      data_row = [:id, :email, :full_name, :job_title, :company, :sign_in_count, :last_sign_in_at].map{|attr| user.send(attr)}
      data_row << user.surveys.count
      data_row << user.plan.kind.humanize
      data_row << user.partner_code

      worksheet.insert_row(@current_row_index += 1, data_row)
    end
  end

  def generate(*args)
    generate_data_sheet
    @report_io = StringIO.new
    @workbook.write(@report_io)
    @report_io.string
  end

protected
  def format_value(value, column_definition)
    if value
      result = case column_definition[:type]
      when :integer then value.to_i
      when :float then value.to_f
      when :percent then value.to_f/100
      when :date then DateTime.parse(value) rescue ''
      else value || ''
      end
    else
      result = ''
    end
    if column_definition.has_key?(:processor)
      self.send(column_definition[:processor], result)
    else
      result
    end
  end
  
  def insert_styled_row(worksheet, row_index, row_data, style)
    worksheet.insert_row(row_index, row_data)
    row_data.each_index {|i| worksheet.row(row_index).set_format(i, FORMAT[style]) }
  end

end