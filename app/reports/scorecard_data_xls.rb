class ScorecardDataXls
  attr_accessor :survey
  
  BAROMETER_MAP = {:pp => 'Enthusiasts', :mp => 'Participants', :mn => 'Indifferent', :pn => 'Detractors'}

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
    0.upto(2) { |i| worksheet.column(i).width = 30 }

    summary = [
      ['e.mote™ Subject', @survey.project_name],
      ['e.mote™ Code', @survey.code],
      ['URL', @survey.emote_direct_link],
      ['Date e.mote™ Created', @survey.created_at.to_s],
      ['Total Responses', @survey.survey_results.count],
      ['Responses Displayed', @survey.survey_results.where(:is_removed => 0).count],
      ['Date of Report', DateTime.now.to_s],
      ['Current e.mote™ Status', @survey.state_human]
    ]

    #Compose summary box
    summary.each_with_index do |row, i|
      worksheet.insert_row i+1, row
      worksheet.row(i+1).set_format(0, FORMAT[:summary_header])
      worksheet.row(i+1).set_format(1, FORMAT[:summary_value])
    end

    row_idx = summary.size+2

    worksheet.insert_row(row_idx += 1, ['Emotion Spectrum Data'])
    worksheet.row(row_idx).set_format(0, FORMAT[:subtable_title])

    insert_styled_row(worksheet, row_idx += 1, ['Emotion', 'Number of Responses'], :subtable_header)
    spectrum_data = @survey.result_obj[:bars].map {|bar| [bar[:name].upcase, bar[:value].to_i] }
    spectrum_data.each do |row|
      worksheet.insert_row row_idx += 1, row
    end
    insert_styled_row(worksheet, row_idx += 1, [ 'Total Responses',  @survey.result_obj[:totals][:total] ], :subtable_footer)

    worksheet.insert_row(row_idx += 2, ['Barometer Data'])
    worksheet.row(row_idx).default_format = FORMAT[:subtable_title]

    insert_styled_row(worksheet, row_idx += 1, ['Category', 'Number of responses', '% of Respondants'], :subtable_header)
    barometer_data = @survey.result_obj[:pie].map do |side_code, count|
      [BAROMETER_MAP[side_code], count, count.to_f / @survey.result_obj[:totals][:total]]
    end
    barometer_data.each do |row|
      worksheet.insert_row row_idx += 1, row
      worksheet.row(row_idx).set_format(2, CELL_TYPE[:percent])
    end
  end

  def generate_comments_sheet
    worksheet = @workbook.create_worksheet(:name => 'e.mote comments')
    
    worksheet.insert_row(row_idx = 0, ['Comment Data'])
    worksheet.row(row_idx).set_format(0, FORMAT[:subtable_title])
    insert_styled_row(worksheet, row_idx += 1, ['Date', 'Emotion', 'Intensity %', 'Barometer Category', 'Email Address', 'clicked email', 'Comment', 'Notes'], :subtable_header)
    @survey.survey_results.where(:is_removed => 0).order(:start_time).each do |response|
      comment_data = [
        response.start_time,
        response.emote.humanize,
        response.intensity_level.to_f/100,
        'bar cat',
        'email',
        'klik?',
        'kament',
        'notez'
      ]
      worksheet.insert_row(row_idx+=1, comment_data)
      worksheet.row(row_idx).set_format(2, CELL_TYPE[:percent])
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