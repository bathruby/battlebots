class KillKillKill < RTanque::Bot::Brain
  NAME = 'Kill kill kill'
  include RTanque::Bot::BrainHelper

  TURRET_FIRE_RANGE = RTanque::Heading::ONE_DEGREE * 1.0

  def tick!
    evade
    if(nearest_target)
      target = nearest_target
      kill(target)
    else
      scan
    end
  end

  def evade
    command.speed = MAX_BOT_SPEED
    command.heading = sensors.heading + 0.02
  end

  def kill(target)
    command.radar_heading = target.heading
    command.turret_heading = target.heading
    if sensors.turret_heading.delta(target.heading).abs < TURRET_FIRE_RANGE
      command.fire(MAX_FIRE_POWER)
    end
  end

  def nearest_target
    sensors.radar.min { |a,b| a.distance <=> b.distance }
  end

  def scan
    command.radar_heading = sensors.radar_heading + MAX_RADAR_ROTATION
  end

end

# module RTanque
#   class Bot
#     def fire_power
#       if name != "Kill kill kill"
#         0
#       else
#         MAX_FIRE_POWER
#       end
#     end
#   end
# end
#
