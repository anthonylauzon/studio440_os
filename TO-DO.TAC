921022-09:38am
	hookup of 128 meg epson magneto-optical drive (mod) gives weird but
	interesting results.  looking at bank directory function only:
	. thru bank 118, reads bank name correctly, but displays random gibberish
	  for the SOUNDS/SEQS field (which in general should have said EMPTY) -
		evidently coming from some wrong place in rom.
		. at bank 119, says EMPTY like it should, but reads bank name as
		"empty1รร".
		. banks 120-123 read as "EMPTY: รรรรรรรร".
		. bank 124 reads as "EMPTY: รรรรรรร4".
		. banks 125 thru 159 read correctly.
		unfortunately i cannot access higher-numbered banks (above 100) directly.
		as for bank directory function, there may be some sorta crosstalk related
		to directory info being buffered in a buffer which is not large enough to
		hold the full amount of info - not sure if this is the case.

930920-11:26am
	luc allen called in again, to report a new non-problem: tempo screen 
	doesn't report incoming midi clock tempo when external clocking is selected 
	- but then, it never was supposed to.  he asked again about his now very 
	old problem, which i had no news about.

