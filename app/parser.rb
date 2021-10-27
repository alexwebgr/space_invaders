require_relative 'invaders/mars_invader'

class Parser
  INVADERS = [
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
    MarsInvader.new(radar_signal).identify
  end
end