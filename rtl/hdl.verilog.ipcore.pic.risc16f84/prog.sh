#!/usr/bin/env bash
# TODO:  Grab the "cable" number from jtagconfig and bail if no blaster found.
# Maybe restart jtagd and retry if no blater found?
#/opt/intelFPGA_lite/21.1/quartus/bin/jtagconfig -n | grep "USB-Blaster" |

/opt/intelFPGA_lite/21.1/quartus/bin/quartus_pgm -c 1 ../../bin/chain_sof.cdf
