class TalkieToaster < RTanque::Bot::Brain
  NAME = 'Talkie Toaster'
  include RTanque::Bot::BrainHelper

  def tick!
    if (!defined?(@direction))
      @direction = 0
    end

    onWall = false
    if (sensors.position.on_top_wall?)
      command.heading = RTanque::Heading::SOUTH
      onWall = true
    elsif (sensors.position.on_bottom_wall?)
      command.heading = RTanque::Heading::NORTH
      onWall = true
    elsif (sensors.position.on_left_wall?)
      command.heading = RTanque::Heading::EAST
      onWall = true
    elsif (sensors.position.on_right_wall?)
      command.heading = RTanque::Heading::WEST
      onWall = true
    end

    if (onWall)
      if (sensors.heading.delta(command.heading) > 0)
        @direction = 1
      else
        @direction = -1
      end
    else
      if (Random.rand(80) < 1)
        @direction = 0 - @direction
      end

      command.heading = sensors.heading + @direction * RTanque::Heading::ONE_DEGREE * 5.0
    end
    command.speed = RTanque::Bot::MAX_SPEED

    reflections = sensors.radar
    reflections = reflections.reject { |r| r.name == NAME }
    nearest = reflections.sort_by { |r| r.distance }.first

    if nearest
      command.radar_heading = nearest.heading
      command.turret_heading = nearest.heading
      command.fire(RTanque::Bot::MAX_FIRE_POWER)
    end
  end
end
