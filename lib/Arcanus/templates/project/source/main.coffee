#= require_tree .

canvas = $("canvas").attr(
  width: App.width
  height: App.height
).pixieCanvas()

window.engine = Engine
  backgroundColor: Color("Slate Gray").lighten(0.2)
  canvas: canvas
  FPS: 60

engine.add "Player",
  x: App.width/2
  y: App.height/2

engine.start()
