class Invader
  private

  attr_reader :face
  attr_reader :radar_signal

  def initialize(radar_signal)
    @radar_signal = radar_signal
  end

  def find_indexes(line, invader_line)
    indexes = []

    line.scan(/#{invader_line}/) { indexes << $~.offset(0)[0] }

    indexes
  end

  def find_positions
    table = []

    radar_signal.each_line.with_index do |line, index|
      face.each do |invader_line|
        column_indexes = find_indexes(line, invader_line[1])
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
    find_positions.each_cons(face.keys.length).select { |key| key.map { |h| h[:id] } == face.keys }.flatten
  end

  def verify_positions
    positions = []
    group_positions.each_slice(face.size) do |slice|
      columns = slice.map { |col| col[:column_indexes] }.uniq
      if columns.size == 1
        positions << { row: slice.first[:row_index], columns: columns.first }
      end
    end

    positions
  end

  public

  def identify
    verify_positions
  end
end
