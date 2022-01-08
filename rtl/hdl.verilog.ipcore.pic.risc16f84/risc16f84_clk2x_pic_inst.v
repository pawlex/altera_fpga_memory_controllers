//
risc16f84_clk2x 
	pic 
	(
		.prog_dat_i(),           // [13:0] ROM read data
		.prog_adr_o(),           // [12:0] ROM address
		.ram_dat_i(),            // [7:0] RAM read data
		.ram_dat_o(),            // [7:0] RAM write data
		.ram_adr_o(),            // [8:0] RAM address; ram_adr[8:7] indicates RAM-BANK
		.ram_we_o(),             // RAM write strobe (H active)
		.aux_adr_o(),            // [15:0] Auxiliary address bus
		.aux_dat_io(),           // [7:0] Auxiliary data bus (tri-state bidirectional)
		.aux_we_o(),             // Auxiliary write strobe (H active)
		.aux_re_o(),             // Auxiliary read  strobe (H active) PK
		.int0_i(),               // PORT-B(0) INT
		.reset_i(),              // Power-on reset (H active)
		.clk_en_i(),             // Clock enable for all clocked logic
		.clk_i()                 // Clock input
	);
