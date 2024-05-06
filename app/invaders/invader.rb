class Invader
  private

  # a comment
  attr_reader :face
  attr_reader :radar_signal

  def initialize(radar_signal)
    @radar_signal = radar_signal
  end

  def indexes(line, invader_line)
    indexes = []

    line.scan(/#{invader_line}/) { indexes << $~.offset(0)[0] }

    indexes
  end

  def positions
    table = []

    radar_signal.each_line.with_index do |line, index|
      face.each do |invader_line|
        column_indexes = indexes(line, invader_line[1])
        table << {
          id: invader_line[0],
          row_index: index,
          column_indexes: column_indexes
        } unless column_indexes.empty?
      end
    end

    table
  end

  def group_positions
    positions.each_cons(face.keys.length).select { |key| key.map { |h| h[:id] } == face.keys }
  end

  def verify_positions
    group_positions.map do |slice|
      columns = slice.map { |col| col[:column_indexes] }.uniq
      { row: slice.first[:row_index], columns: columns.first } if columns.size == 1
    end.compact
  end

  public

  def identify
    verify_positions
  end
end
