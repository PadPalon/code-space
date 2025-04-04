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
- turn left X
  - turn left by X degress
- turn r | turn right
  - turn right by 45 degress
- turn right X
  - turn right by X degress
- reverse
  - turn around 180 degrees
- execute
  - run commands