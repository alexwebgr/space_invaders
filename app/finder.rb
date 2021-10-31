require_relative 'invaders/mars_invader'
require_relative 'invaders/jupiter_invader'

class Finder
  KNOWN_INVADERS = [MarsInvader, JupiterInvader]
  private_constant :KNOWN_INVADERS

  private

  attr_reader :invaders
  attr_reader :radar_signal

  def initialize(radar_signal, invaders = KNOWN_INVADERS)
    @invaders = invaders
    @radar_signal = radar_signal
  end

  public

  def identify_invaders
    invaders.each_with_object({}) { |invader, positions| positions[invader.name] = invader.new(radar_signal).identify }
  end
end