class Chaos2 < RTanque::Bot::Brain
  NAME = "Chaos 2"
  include RTanque::Bot::BrainHelper

  TURRET_FIRE_RANGE = RTanque::Heading::ONE_DEGREE * 5.0

  def tick!
    command.fire_power = 2
    command.speed = 10
    command.heading = sensors.heading - (RTanque::Heading::ONE_DEGREE * (rand*40-10))
    command.turret_heading = sensors.turret_heading - (RTanque::Heading::ONE_DEGREE * (rand*40-10))

    # turn turrent to face other bot

    @desired_heading ||= nil

    if (lock = self.get_radar_lock)
      self.destroy_lock(lock)
      @desired_heading = nil
    else
      Chaos2::NAME.replace "#{NAME.gsub(/\(.+?\)/, '')}"
      seek_lock
    end
  end

  def destroy_lock(reflection)
    command.radar_heading = reflection.heading
    command.turret_heading = reflection.heading

    command.heading = sensors.heading - (RTanque::Heading::ONE_DEGREE * (rand*50-10))

    # change speed based on how close to the target
    command.speed = if reflection.distance > 100
      MAX_BOT_SPEED
      command.fire(5)
    elsif reflection.distance < 50
      -MAX_BOT_SPEED
      command.fire(1)
    else
      command.fire(3)
      MAX_BOT_SPEED.to_f/reflection.distance
    end
  end

  def seek_lock
    if sensors.position.on_wall?
      @desired_heading = sensors.heading + RTanque::Heading::HALF_ANGLE
      command.speed = -MAX_BOT_SPEED
    else
      command.speed = MAX_BOT_SPEED
    end
    command.radar_heading = sensors.radar_heading + MAX_RADAR_ROTATION

    if @desired_heading
      command.heading = @desired_heading
      command.turret_heading = @desired_heading
    else
      command.heading = sensors.heading - (RTanque::Heading::ONE_DEGREE * (rand*40-10))
      command.turret_heading = sensors.turret_heading - (RTanque::Heading::ONE_DEGREE * (rand*40-10))
    end
  end

  def get_radar_lock
    @locked_on ||= nil
    lock = if @locked_on
      Chaos2::NAME.replace "#{NAME.gsub(/\(.+?\)/, '')}(#{@locked_on.gsub(/\(.+?\)/, '')})"
      sensors.radar.find { |reflection| reflection.name == @locked_on } || sensors.radar.first
    else
      sensors.radar.first
    end
    @locked_on = lock.name if lock
    lock
  end
end
