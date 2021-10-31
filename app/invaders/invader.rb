class Invader
  private

  attr_reader :face
  attr_reader :radar_signal

  def initialize(radar_signal)
    @radar_signal = radar_signal
  end

  def find_positions
    table = []
    row = 0
    radar_signal.each_line do |line|
      face.each do |invader_line|
        column_indexes = (0...line.length).select { |i| line[i, invader_line.length] == invader_line }
        table << {
          row_index: row,
          column_indexes: column_indexes
        } unless column_indexes.empty?
      end

      row += 1
    end

    positions = []
    table.each_slice(face.size) do |slice|
      columns = slice.map { |col| col[:column_indexes] }.uniq
      if slice.size == face.size && columns.size == 1
        positions << { row: slice.first[:row_index], columns: columns.first }
      end
    end

    positions
  end

  public

  def identify
    find_positions
  end
end
