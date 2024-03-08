require_relative 'invader'

class JupiterInvader < Invader
  FACE = {
    a: '---oo---',
    b: '--oooo--',
    c: '-oooooo-',
    d: 'oo-oo-oo',
    e: 'oooooooo',
    f: '--o--o--',
    g: '-o-oo-o-',
    h: 'o-o--o-o'
  }

  def initialize(radar_signal)
    super
    @face = FACE
  end

  def say_hi
    p "hello"
  end

  def say_hi_again
    p "hello"
  end
end
