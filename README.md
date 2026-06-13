# CODE-SPACE

Godot project to experiment with controlling a space ship by entering and running sequential commands.
Think "Captain shouting orders to the officers" and "Execute battleplan Super-Omega-Scheisser".

## Commands

- thrust X
  - run the engines for X seconds
- rotate X
  - rotate to X degrees
- rotate pro | rotate prograde
  - rotate towards the current velocity vector
- rotate retro | rotate retro
  - rotate away from the current velocity vector
- turn l | turn left
  - turn left by 45 degress
- turn l X | left X
  - turn left by X degress
- turn r | turn right
  - turn right by 45 degress
- turn r X | right X
  - turn right by X degress
- reverse
  - turn around 180 degrees
- spin l | spin left
  - spin left for 1 second
- spin l X | spin left X
  - spin left for X second
- spin r | spin right
  - spin right for 1 second
- spin r X | spin right X
  - spin right for X second
- execute
  - run commands
