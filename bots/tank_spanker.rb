class TankSpanker < RTanque::Bot::Brain
  NAME = 'TankSpanker'
  include RTanque::Bot::BrainHelper

  TURRET_FIRE_RANGE = RTanque::Heading::ONE_DEGREE * 1.5

  def tick!
    self.evade
    # make_circles

    if(self.nearest_target)
      target = nearest_target
      kill(target)
    else
      scan
      make_circles
    end

    at_tick_interval(100) do
      puts sensors.inspect
      puts "Tick ##{sensors.ticks}!"
      puts " Gun Energy: #{sensors.gun_energy}"
      puts " Health: #{sensors.health}"
      puts " Position: (#{sensors.position.x}, #{sensors.position.y})"
      puts sensors.position.on_wall? ? " On Wall" : " Not on wall"
      puts " Speed: #{sensors.speed}"
      puts " Heading: #{sensors.heading.inspect}"
      puts " Turret Heading: #{sensors.turret_heading.inspect}"
      puts " Radar Heading: #{sensors.radar_heading.inspect}"
      puts " Radar Reflections (#{sensors.radar.count}):"
      sensors.radar.each do |reflection|
        puts "  #{reflection.name} #{reflection.heading.inspect} #{reflection.distance}"
      end
    end
  end

  def evade
    command.speed = MAX_BOT_SPEED
    command.heading = sensors.heading + 0.02
  end

  def kill(target)
    self.command.radar_heading = target.heading
    self.command.turret_heading = target.heading
    if self.sensors.turret_heading.delta(target.heading).abs < TURRET_FIRE_RANGE
      self.command.fire(MAX_FIRE_POWER)
    end
  end

  def nearest_target
    self.sensors.radar.min { |a,b| a.distance <=> b.distance }
  end

  def scan
    self.command.radar_heading = self.sensors.radar_heading + MAX_RADAR_ROTATION
  end
    ## main logic goes here
    # use self.sensors to detect things
    # use self.command to control tank
    # self.arena contains the dimensions of the arena
    # self.command.radar_heading = self.sensors.radar_heading + MAX_RADAR_ROTATION
    # make_circles
    # self.command.radar_heading = self.sensors.radar_heading + MAX_RADAR_ROTATION
    # command.fire(0.25)

    # if sensors.position.on_wall?
    #   command.heading = RTanque::Heading.new(RTanque::Heading::WEST)
    # end


  def make_circles
    command.speed = -2 # takes a value between -5 to 5
    command.heading = sensors.heading + 0.01
  end
end