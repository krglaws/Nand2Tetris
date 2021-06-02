// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Fill.asm

// Runs an infinite loop that listens to the keyboard input.
// When a key is pressed (any key), the program blackens the screen,
// i.e. writes "black" in every pixel;
// the screen should remain fully black as long as the key is pressed. 
// When no key is pressed, the program clears the screen, i.e. writes
// "white" in every pixel;
// the screen should remain fully clear as long as no key is pressed.

(listen)
  // set fill/clear params
  @SCREEN
  D = A
  @R0
  M = D // SCREEN ptr

  @8192
  D = A
  @R2
  M = D // fill size

  @KBD
  D = M // grab current key press value
  @fill
  D; JNE // if key pressed, go to fill
  @clear
  0; JEQ // else go to clear

(fill)
  // check if already filled
  @R5
  D = M
  @listen
  D; JNE

  // not filled, set filled state
  @R5
  M = 1

  // set fill value
  @R1
  M = -1

  // goto memset
  @memset
  0; JEQ

(clear)
  // check if already cleared
  @R5
  D = M
  @listen
  D; JEQ

  // not cleared, set cleared state
  @R5
  M = 0

  // set fill value
  @R1
  M = 0

  // goto memset
  @memset
  0; JEQ

// R0 - starting address
// R1 - value to set
// R2 - number of words
(memset)
  // init offset value in R3
  @R3
  M = 0

(memloop)
  // if (R3 >= R2) break;
  @R3
  D = M
  @R2
  D = D - M
  @listen
  D; JGE

  // *(R0 + R3) = R1
  @R0
  D = M
  @R3
  D = D + M
  @R4
  M = D // save dest
  @R1
  D = M // fetch value
  @R4
  A = M
  M = D

  // R3++
  @R3
  M = M + 1
  @memloop
  0; JEQ
