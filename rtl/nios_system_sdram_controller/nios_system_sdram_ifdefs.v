// -----------------------------------------------------------------------------
// Copyright (c) 2021 All rights reserved
// -----------------------------------------------------------------------------
// Author : paul komurka (pawl) pawlex@gmail.com
// File   : sdram_init_reader_writer.v
// Create : 2021-12-12
// Revise : 1.0
// Editor : vim/quartus
// -----------------------------------------------------------------------------

`ifdef DATA_EQ_ADDRESS
	assign data_pattern = ( o_addr[15:0] );
`endif
`ifdef DATA_EQ_LFSR
	`define LFSR
	assign data_pattern = ( lfsr_data[15:0] );
`endif
`ifdef DATA_EQ_ADDR_XOR
	`define ADDR_XOR
	assign data_pattern = ( address_xor[15:0] );
`endif
`ifdef DATA_EQ_ADDR_XOR_LFSR
	`define LFSR
	`define ADDR_XOR
	assign data_pattern = ( lfsr_data[15:0] ^ address_xor[15:0] );
`endif
`ifdef ADDR_XOR
  wire [15:0] address_xor; assign address_xor = (o_addr[15:0] ^ XOR_MASK);
`endif
`ifdef LFSR
    wire [15:0] lfsr_data; // data pattern needs to be deterministic for reads and writes.  so a free-running clock isn't appropriate.
    wire lfsr_clk; assign lfsr_clk = read_address[0] ^ write_address[0]; // clock the LFSR whenever the read or write address changes
    wire lfsr_reset; assign lfsr_reset = (start_reading | start_writing); // reset the LFSR whenever we start a read or write loop
    reg lfsr_reset_ff; always @(posedge clk) lfsr_reset_ff <= lfsr_reset; // give the LFSR 2x clock pulse.  probably unnecessary
    wire lfsr_reset_n; assign lfsr_reset_n = ~(lfsr_reset|lfsr_reset_ff); // ^^
	lfsr lfsr_0
	(
		.clk(lfsr_clk),
		.reset_n(lfsr_reset_n),
		.out(lfsr_data)
	);

`endif

// DEBUG OUTPUT
`ifdef INITIAL_DEBUG
	assign o_debug[7:0] = {read_state[2:0],write_state[2:0],state[1:0]};
	assign o_debug[11:8] = {o_rd_n, o_wr_n, i_wait_req,i_trigger};
	assign o_debug[15:12] = o_read_error_count[3:0];
`endif


`ifdef DEBUG
	//assign o_debug[7:0]  = read_address_ff[7:0];
	//assign o_debug[15:8] = read_return_data[7:0];
	//assign o_debug[7:0]  = read_address[7:0];
	//assign o_debug[15:8] = i_data[7:0];
	//assign o_debug[15:0] = {write_state[3:0],read_state[5:0], state[5:0]};
	//assign o_debug[7:0]  = {writet_state[2:0]};
	//assign o_debug[5:0] = { o_addr[5:0] };
	//assign o_debug[11:6] = { read_return_data[5:0] };
	//assign o_debug[15:12] = { read_error_count[3:0] };
	//assign o_debug[15:8] = { o_addr[21:18], o_addr[3:0] };
	//assign o_debug[5:0]  = { o_rd_n, o_wr_n, i_wait_req, i_valid, reading, writing };
	//assign o_debug[7:0] = lfsr_data[7:0];
	//assign o_debug[15:0] = read_error_count[15:0];
	//assign o_debug[15:0] = read_data_xor_ff[15:0];
	assign o_debug[15:0] = rw_loop_count[15:0];
	//assign o_debug[15:8] = read_return_data[7:0];
	//assign o_debug[15:4] = o_data[11:0];
	//assign o_debug[3:0] = {2'b00, lfsr_reset_n, lfsr_clk};
`endif
