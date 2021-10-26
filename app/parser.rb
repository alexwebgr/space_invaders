class Parser
  INVADERS = [
'--o-----o--
---o---o---
--ooooooo--
-oo-ooo-oo-
ooooooooooo
o-ooooooo-o
o-o-----o-o
---oo-oo---
'.split("\n"),
'---oo---
--oooo--
-oooooo-
oo-oo-oo
oooooooo
--o--o--
-o-oo-o-
o-o--o-o
'.split("\n")
  ]
  attr_reader :radar_signal

  def initialize(radar_signal)
    @radar_signal = radar_signal
  end

  def identify_invaders
    column = []
    row = 0
    radar_signal.each_line do |line|
      INVADERS[0].each do |invader_line|
        line_index = line.index(invader_line)
        column << {
          start_row: row,
          column_check: line_index
        } unless line_index.nil?
      end

      row += 1
    end

    if column.map { |col| col[:column_check] }.uniq.size > 1
      return []
    end

    [column.first[:start_row], column.map { |col| col[:column_check] }.uniq.first]
  end
end