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
    table = []
    row = 0
    radar_signal.each_line do |line|
      INVADERS[0].each do |invader_line|
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
end