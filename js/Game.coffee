class Game
  # instance = null
  stageSize = { width: 800, height: 400 }

  constructor: ->
    @setupCanvas()

  setupCanvas: ->
    #@stage = Snap(stageSize.width, stageSize.height)
    $gameContainer = $('<div id="game" class="game-container"></div>').prependTo('body')
    $gameContainer.css
      width:  stageSize.width
      height: stageSize.height

    @stage = Snap(stageSize.width, stageSize.height)
    @stage.rect(0, 0, stageSize.width, stageSize.height).attr({fill: 'transparent'})
    $gameContainer.append(@stage.node) # um..
    @world = new World(@stage, stageSize)

  # @get: ->
  #   instance ?= new Game()


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


class Tank
  # healthLevel = 100
  # shieldLevel = 0
  weaponAngle = 45
  weaponPower = 10


game = new Game()
