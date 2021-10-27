require_relative 'invader'

class MarsInvader < Invader
  FACE = '--o-----o--
---o---o---
--ooooooo--
-oo-ooo-oo-
ooooooooooo
o-ooooooo-o
o-o-----o-o
---oo-oo---
'.split("\n")

  def initialize(radar_signal)
    super
    @face = FACE
  end
end