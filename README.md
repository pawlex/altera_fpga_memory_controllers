# Memory Controller project for the BeMicro MAX10 FPGA development kit.
<p> Why not a DE nano?  Well I have a few of these.  They're low power with on-board DRAM and plenty of pin headers.  I've cultivated a nice template for working with these kits.  The MAX 10 is technically a CPLD -- So don't expect too much with respect to fMax.</p>

## Structure
/rtl - ip cloned in from other repos.  Usually with a test bench suitable for iverilog/gtkwave (see my public template for details).

/altera - includes all the project files and quartus specific megafunction blocks

/documentation - datasheets etc.

/release - quartus archives at specific milestones.
