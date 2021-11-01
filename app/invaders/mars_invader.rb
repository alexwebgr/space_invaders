require_relative 'invader'

class MarsInvader < Invader
  FACE = {
    a: '--o-----o--',
    b: '---o---o---',
    c: '--ooooooo--',
    d: '-oo-ooo-oo-',
    e: 'ooooooooooo',
    f: 'o-ooooooo-o',
    g: 'o-o-----o-o',
    h: '---oo-oo---'
  }

  def initialize(radar_signal)
    super
    @face = FACE
  end
end