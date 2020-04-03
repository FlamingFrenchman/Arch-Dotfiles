- Make `defaultcs` and optionally `defaultrcs` non-static
  and declare them `extern` in st.h
- Add `case` statements to the control sequence switch in
  st.c. `p` shall be the argument given with the sequence
  and `j` shall be one of `defaultbg`, `defaultfg`, and
  `defaultcs`. Call `xsetcolor`.
- If the alpha patch is installed, copy the block of code
  in `xloadcols` that sets the alpha value for the
  background.
- pywal generates and sends escape sequences for colors
  232 and 257 as background, and 256 as foreground. Don't
  use these colors since they're not gonna be what you
  expect them to be.
- do not check for `opt_alpha` when setting alpha value
  with control sequences
- if any terminal application is giving you shit, just get
  rid of the terminal sequence patch
