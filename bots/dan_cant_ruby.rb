class DanCantRuby < RTanque::Bot::Brain
  NAME = 'dan_cant_ruby'
  include RTanque::Bot::BrainHelper

  def tick!
    ## main logic goes here
    
    # use self.sensors to detect things
    # See http://rubydoc.info/github/awilliams/RTanque/master/RTanque/Bot/Sensors
    
    # use self.command to control tank
    # See http://rubydoc.info/github/awilliams/RTanque/master/RTanque/Bot/Command
    
    # self.arena contains the dimensions of the arena
    # See http://rubydoc.info/github/awilliams/RTanque/master/frames/RTanque/Arena

    command.speed = 2
#    command.heading = sensors.heading + Math::PI / 32.0
    command.heading = Math::sin((sensors.position.y + 1) / (sensors.position.x + 1)) * Math::PI * 2.0
    #puts "#{sensors.position.x},#{sensors.position.y}"
#    nearest = sensors.radar.min {|a,b| a.distance <=> b.distance}
    if sensors.radar.count > 0
      target = sensors.radar.first
      command.radar_heading = target.heading
      command.turret_heading = target.heading
    else
      command.radar_heading = Math::PI / 8.0
      command.turret_heading = sensors.turret_heading + 0.2 #Math::PI * 3.0 / 4.0

    end
    command.fire(2)
  end
end
