require_relative '../app/finder'

namespace :space_invaders do
  desc 'Identify invaders in a radar signal'
  task :identify, [:signal] do |t, args|
    signal = args[:signal]
    raise 'Provide the path to the signal file. e.g. bundle exec rake space_invaders:identify[app/signals/one_mars_one_jupiter.txt]' if signal.nil?

    radar_signal = Pathname.new(signal).read

    pp Finder.new(radar_signal).identify_invaders
  end
end
