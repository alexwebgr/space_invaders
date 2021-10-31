require_relative 'invader'

class MarsInvader < Invader
  # FACE = <<~EOS.split
  #   --o-----o--
  #   ---o---o---
  #   --ooooooo--
  #   -oo-ooo-oo-
  #   ooooooooooo
  #   o-ooooooo-o
  #   o-o-----o-o
  #   ---oo-oo---
  # EOS

  FACE = {
    a: '--o-----o--',
    b: '---o---o---',
    c: '--ooooooo--',
    d: '-oo-ooo-oo-',
    e: 'ooooooooooo',
    f: 'o-ooooooo-o',
    g: 'o-o-----o-o',
    h: '---oo-oo---',
  }

  def initialize(radar_signal)
    super
    @face = FACE
  end
end