/*

This is for MIDI bootstrap loader -
only one or a few obj modules,
defaulted to region MAIN.
Set one overlay address to put program where desired.

Currently located at bottom of Abs.W RAM area.

*/


partition
   {
   overlay
      {
      region {} MAIN    [addr=0x0001fe00];
      }
      bootstrap;
   }
   BOOTSTRAP [addr=0];

