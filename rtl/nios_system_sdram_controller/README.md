# Altera SDRAM memory controller with 2 entry EFIFO and AVALON Interface (old style) ?
<p>I do not have a BFM for the simulation here, nor is the RTL written with any delays, so sim is a crap-shoot.  However, I have noticed that if incorrect timing is used with respect to WR# signal, then a spurious read will occur.</p>
<p>The RTL is not well documented, and I may or may not fix this later, but for now writes appear to be working.  No reads have been simulated due to lack of BFM.</p>

![](nios_system_sdram_controller.png)
![](spurious_raw.PNG)
![](Avalon_Waveform.png)
