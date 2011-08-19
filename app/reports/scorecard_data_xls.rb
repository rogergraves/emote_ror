class ScorecardDataXls
  attr_accessor :survey
  
  CELL_TYPE = {
    :float => Spreadsheet::Format.new( :number_format => '0.00' ),
    :percent => Spreadsheet::Format.new( :number_format => '0.00%' ),
  }

  FORMAT = {
    :summary_header => Spreadsheet::Format.new(
       :bold => true,
       :horizontal_align => :right,
       :left => true, :right => true, :top => true, :bottom => true,
       :pattern => 1, :pattern_fg_color => :silver
    ),
    :summary_value => Spreadsheet::Format.new(
       :bold => true,
       :right => true, :top => true, :bottom => true,
       :horizontal_align => :right
    ),
    :subtable_title => Spreadsheet::Format.new(
       :bold => true,
       #:horizontal_align => :merge,
       #:merge_range => 2,
       :size => 12
    ),
    :subtable_header => Spreadsheet::Format.new(
       :bold => true,
       :horizontal_align => :center,
       :bottom => true
     ),
    :subtable_footer => Spreadsheet::Format.new(
       :bold => true,
       :top => true,
       :horizontal_align => :left
     )
  }


  def initialize
    @workbook = Spreadsheet::Workbook.new
  end

  def generate_data_sheet
    worksheet = @workbook.create_worksheet(:name => 'e.mote data')
    0.upto(7) { |i| worksheet.column(i).width = 30 }
    worksheet.column(6).width = 100
    worksheet.column(5).width = 15

    summary = [
      ['e.mote™ Subject', @survey.project_name],
      ['e.mote™ Code', @survey.code],
      ['URL', @survey.emote_direct_link],
      ['Date e.mote™ Created', @survey.created_at.to_s],
      ['Total Responses', @survey.all_responses.count],
      ['Responses Displayed', @survey.visible_responses.count],
      ['Date of Report', DateTime.now.to_s],
      ['Current e.mote™ Status', @survey.state_human]
    ]

    #Compose summary box
    summary.each_with_index do |row, i|
      worksheet.insert_row i+1, row
      worksheet.row(i+1).set_format(0, FORMAT[:summary_header])
      worksheet.row(i+1).set_format(1, FORMAT[:summary_value])
    end

    @current_row_index = summary.size+2

    worksheet.insert_row(@current_row_index += 1, ['Emotion Spectrum Data'])
    worksheet.row(@current_row_index).set_format(0, FORMAT[:subtable_title])

    insert_styled_row(worksheet, @current_row_index += 1, ['Emotion', 'Number of Responses'], :subtable_header)
    spectrum_data = @survey.result_obj[:bars].map {|bar| [bar[:name].upcase, bar[:value].to_i] }
    spectrum_data.each do |row|
      worksheet.insert_row @current_row_index += 1, row
    end
    insert_styled_row(worksheet, @current_row_index += 1, [ 'Total Responses',  @survey.result_obj[:totals][:total] ], :subtable_footer)

    worksheet.insert_row(@current_row_index += 2, ['Barometer Data'])
    worksheet.row(@current_row_index).default_format = FORMAT[:subtable_title]

    insert_styled_row(worksheet, @current_row_index += 1, ['Category', 'Number of responses', '% of Respondants'], :subtable_header)
    barometer_data = @survey.result_obj[:pie].map do |side_code, count|
      [SurveyResult::BAROMETER_MAP[side_code][:name], count, count.to_f / @survey.result_obj[:totals][:total]]
    end
    barometer_data.each do |row|
      worksheet.insert_row @current_row_index += 1, row
      worksheet.row(@current_row_index).set_format(2, CELL_TYPE[:percent])
    end
  end

  def generate_comments_sheet
    @current_row_index += 5
    worksheet = @workbook.worksheets.first
    
    worksheet.insert_row(@current_row_index, ['Comment Data'])
    worksheet.row(@current_row_index).set_format(0, FORMAT[:subtable_title])
    insert_styled_row(worksheet, @current_row_index += 1, ['Date', 'Emotion', 'Intensity %', 'Barometer Category', 'Email Address', 'clicked email', 'Comment', 'Notes'], :subtable_header)
    @survey.visible_responses.order(:start_time).each do |response|
      comment_data = [
        response.start_time,
        response.emote.humanize,
        response.intensity_level.to_f/100,
        SurveyResult.barometer_category_from_intensity(response.emote, response.intensity_level, true),
        response.email,
        response.email_used ? 'Yes' : 'No',
        response.verbatim
      ]
      worksheet.insert_row(@current_row_index+=1, comment_data)
      worksheet.row(@current_row_index).set_format(2, CELL_TYPE[:percent])
    end
  end

  def generate(*args)
    generate_data_sheet
    generate_comments_sheet
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