class FletchBot < RTanque::Bot::Brain
  NAME = 'FletchBot'
  include RTanque::Bot::BrainHelper

  def initialize(arena)
    @oldHeading = RTanque::Heading.new(0)
    super(arena)
  end

  def tick!
    ## main logic goes here

    if sensors.radar.count > 0
      target = sensors.radar.first

      command.radar_heading = target.heading
      headingDelta = target.heading - @oldHeading
      angleAhead = headingDelta * 80
      p angleAhead
      command.turret_heading = target.heading + angleAhead
      command.fire(1)

      @oldHeading = target.heading
    else
      command.radar_heading = sensors.radar_heading + 3.14/4;
    end

    #sensors.radar.each do |reflection|
    #  puts "  #{reflection.name} #{reflection.heading.inspect} #{reflection.distance}"
    #end

    # use self.sensors to detect things
    # See http://rubydoc.info/github/awilliams/RTanque/master/RTanque/Bot/Sensors

    # use self.command to control tank
    # See http://rubydoc.info/github/awilliams/RTanque/master/RTanque/Bot/Command

    # self.arena contains the dimensions of the arena
    # See http://rubydoc.info/github/awilliams/RTanque/master/frames/RTanque/Arena
  end
end
