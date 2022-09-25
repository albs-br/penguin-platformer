# go-penguin
Platform game for MSX 1 with pixel fine scroll (maybe 8 directions), parallax background, 2 color player and enemies (3 per line), and more

How to play:
* Press left and right keys to move;
* Press `X` key to jump;
* Press `Z` key to run;

Video of demo version: https://youtu.be/dcibKzg89l8

[![IMAGE ALT TEXT](http://img.youtube.com/vi/dcibKzg89l8/0.jpg)](http://www.youtube.com/watch?v=dcibKzg89l8 "Go Penguin")

Play it online now:
https://webmsx.org/?MACHINE=MSX1&ROM=https://github.com/albs-br/penguin-platformer/releases/download/v.0.75.2/go-penguin.rom&CARTRIDGE1_FORMAT=ASCII16

To play it on openMSX, you can type the command:
```
openmsx -machine msx1 go-penguin.rom -romtype ASCII16
```

Info on development here:
https://www.msx.org/forum/msx-talk/development/first-test-horizontal-scrolling-game-possibly-named-penguim-platformer#comment-400553

How to compile
--------------
* Install Java runtime in your PATH;
* Install mdl.jar from [mdlz80optimizer](https://github.com/santiontanon/mdlz80optimizer);
* Set MDL variable at the beginning of the Makefile to point to where you put mdl.jar.

[![HitCount](http://hits.dwyl.com/albs-br/penguin-platformer.svg)](http://hits.dwyl.com/albs-br/penguin-platformer)
