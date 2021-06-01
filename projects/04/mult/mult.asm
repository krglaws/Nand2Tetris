// This file is part of www.nand2tetris.org
// and the book "The Elements of Computing Systems"
// by Nisan and Schocken, MIT Press.
// File name: projects/04/Mult.asm

// Multiplies R0 and R1 and stores the result in R2.
// (R0, R1, R2 refer to RAM[0], RAM[1], and RAM[2], respectively.)

// R0 is the 'adding' register, and R1 is the 'decrementing' register
// so make sure R1 < R0
(init)
  // initialize R2 to zero
  @2
  M = 0

  // copy R0 into R3
  @0
  D = M
  @3
  M = D

  // compare R3 to R1
  @1
  D = M
  @3
  D = M - D

  // jump to add_loop if R0 >= R1
  @add_loop
  D; JGE

(swap)
  // move R0 into R3
  @0
  D = M
  @3
  M = D

  // move R1 into R0
  @1
  D = M
  @0
  M = D

  // move R3 into R1
  @3
  D = M
  @1
  M = D

(add_loop)
  // check if R1 == 0
  @1
  D = M;
  @done
  D; JEQ

  // set R2 = R2 + R0
  @0
  D = M
  @2
  M = M + D

  // decrement R1
  @1
  M = M - 1

  // loop
  @add_loop
  0; JEQ

// infinite loop
(done)
  0; JEQ
