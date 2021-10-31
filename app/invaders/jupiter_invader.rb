require_relative 'invader'

class JupiterInvader < Invader
  FACE = <<~EOS.split
    ---oo---
    --oooo--
    -oooooo-
    oo-oo-oo
    oooooooo
    --o--o--
    -o-oo-o-
    o-o--o-o
  EOS

  def initialize(radar_signal)
    super
    @face = FACE
  end
end