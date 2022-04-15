require_relative 'invaders/mars_invader'
require_relative 'invaders/jupiter_invader'

class Finder
  KNOWN_TARGETS = [MarsInvader, JupiterInvader]
  private_constant :KNOWN_TARGETS

  private

  attr_reader :targets
  attr_reader :radar_signal

  def initialize(radar_signal, targets = KNOWN_TARGETS)
    @targets = targets
    @radar_signal = radar_signal
  end

  public

  def identify
    targets.each_with_object({}) { |target, positions| positions[target.name] = target.new(radar_signal).identify }
  end
end
