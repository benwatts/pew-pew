class Game
  # instance = null
  stageSize = { width: 800, height: 400 }

  constructor: ->
    @setupCanvas()

  setupCanvas: ->
    #@stage = Snap(stageSize.width, stageSize.height)
    @stage = Snap(stageSize.width, stageSize.height)
    @stage.rect(0, 0, stageSize.width, stageSize.height).attr({fill: 'transparent'})
    $('#stage-container').append(@stage.node) # um..
    @world = new World(@stage, stageSize)

    t = new Tank(@stage, stageSize)

class Tank
  tangle = 90

  constructor: (@stage, @stageSize) ->
    @drawTank()
    @body        = null
    @enabled     = false
    @turretAngle = 90

  drawTank: ->
    tankHeight = 20
    @body = @stage.rect 100, @stageSize.height-50-tankHeight, 40, tankHeight
    #body = @stage.path
    @drawTurret()
    @enableControls()

  drawTurret: ->
    turretLength = 18
    turretWidth = 4
    tankWidth = parseInt @body.attr 'width'
    tankBodyX = parseInt @body.attr 'x'
    tankBodyY = parseInt @body.attr 'y'
    middleOfTank = tankBodyX + tankWidth/2

    @turret = @stage.path "M#{middleOfTank},#{tankBodyY}, v#{-turretLength+turretWidth}"
    @turret.attr
      strokeWidth: turretWidth
      stroke: '#000'

  enableControls: ->
    @enabled = true
    $('body').on 'keydown', @moveTurret

  disableControls: ->
    @enabled = false
    $('body').off 'keydown', @moveTurret

  moveTurret: (e) =>
    if e.which is 39 and (@turretAngle < 90) # right arrow
      @turretAngle += 2
    else if e.which is 37 and (@turretAngle > -90) # left arrow
      @turretAngle -= 2
    @moveTurretTo(@turretAngle)

    $('#turret-angle').text(@turretAngle) # oh...

  moveTurretTo: (delta) ->
    bb = @turret.getBBox()
    console.log @turret, bb.x, bb.y2
    @turret.transform "rotate(#{delta}, #{bb.x}, #{bb.y2})"





###
- wind?
- randomized terrain?
- option to pick types of terrain
- terrain destruction
- oh... terrain collapsing
###
class World
  constructor: (@s, @sSize) ->
    @drawSky()
    @drawGround()

  drawSky: ->
    gradient = @s.gradient "l(0, 0, 0, 1)#7cc8de-#f4e68c"
    @sky = @s.rect(0, 0, @sSize.width, @sSize.height)
    @sky.attr
      fill: gradient

  drawGround: ->
    simpleHeight = 50
    @terrain = @s.rect(0, @sSize.height-simpleHeight, @sSize.width, simpleHeight)
    @terrain.attr
      fill: '#6e6c61'


scorched = new Game()
