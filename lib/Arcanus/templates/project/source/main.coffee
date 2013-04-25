#= require_tree .

canvas = $("canvas").pixieCanvas()

window.engine = Engine
  backgroundColor: Color("Slate Gray").lighten(0.2)
  canvas: canvas
  FPS: 60

engine.add "Player",
  x: App.width/2
  y: App.height/2

engine.start()
