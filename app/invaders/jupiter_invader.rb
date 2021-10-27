require_relative 'invader'

class JupiterInvader < Invader
  FACE = '---oo---
--oooo--
-oooooo-
oo-oo-oo
oooooooo
--o--o--
-o-oo-o-
o-o--o-o
'.split("\n")

  private

  def find_positions_columns
    table = []
    row = 0
    radar_signal.each_line do |line|
      FACE.each do |invader_line|
        count = (0...line.length).select { |i| line[i, invader_line.length] == invader_line }
        table << {
          start_row: row,
          column_check: count
        } unless count.empty?
      end

      row += 1
    end

    if table.map { |col| col[:column_check] }.uniq.size > 1
      return []
    end

    [table.first[:start_row], table.map { |col| col[:column_check] }.uniq.first]
  end

  public

  def identify
    find_positions_columns
  end
end