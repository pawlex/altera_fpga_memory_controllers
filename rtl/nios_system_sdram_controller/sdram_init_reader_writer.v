// -----------------------------------------------------------------------------
// Copyright (c) 2021 All rights reserved
// -----------------------------------------------------------------------------
// Author : paul komurka (pawl) pawlex@gmail.com
// File   : sdram_init_reader_writer.v
// Create : 2021-12-12
// Revise : 1.0
// Editor : vim/quartus
// -----------------------------------------------------------------------------

module sdram_init_reader_writer
(
	input clk,
	input reset_n,
	//
	input i_valid,
	input i_wait_req,
	input i_trigger,
	input [15:0] i_data,
	//
	output o_rd_n,
	output o_wr_n,
	output o_error,
	o_ram_reading,
	o_ram_writing,
	output [15:0] o_data,
	output [21:0] o_addr,
	output [1:0] o_be_n,
	output [15:0] o_debug,
	output reg [15:0] o_read_error_count
	
);
`include "nios_system_sdram_params.v"
reg [21:0] read_address;
reg [21:0] write_address;
reg [15:0] read_return_data;
reg [15:0] read_expected_data;
reg [31:0] rw_loop_count;
reg [7:0]  valid_pipe; /* synthesis syn_keep syn_encoding="one-hot" */
reg [15:0] read_data_xor_ff;
reg rd_n, wr_n,read_error_ff;

assign o_be_n = 2'h0;
assign o_rd_n = rd_n;
assign o_wr_n = wr_n;
assign o_addr = reading ? read_address : write_address;
assign o_data = (data_pattern);
assign o_ram_reading = reading;
assign o_ram_writing = writing;
assign o_error = (o_read_error_count > 0);


wire start_reading; assign start_reading = (reading & read_state[0] );
wire start_writing; assign start_writing = (writing & write_state[0]);
wire done_reading; assign done_reading = read_state[7];
wire done_writing; assign done_writing = write_state[7];
wire reading; assign reading = state[3];
wire writing; assign writing = state[2];
wire idle; assign idle = state[2];
wire read_error; assign read_error = (read_data_xor_ff && rw_loop_count);
wire [15:0] read_data_xor; assign read_data_xor = (read_return_data[15:0] ^ read_expected_data[15:0]);
wire [15:0] data_pattern; 

/*
	PICK YOUR DATA PATTERN
*/
//`define DATA_EQ_ADDRESS
//`define DATA_EQ_LFSR
//`define DATA_EQ_ADDR_XOR
`define DATA_EQ_ADDR_XOR_LFSR
// Enable CHIPSCOPE
`define DEBUG

///////////////////////////////////////////////////////
`include "nios_system_sdram_ifdefs.v"
///////////////////////////////////////////////////////

// BEGIN CONTROL_STATE;
reg [7:0] state; /* synthesis syn_encoding = "one-hot" */
always @(posedge clk or negedge reset_n)
	if(!reset_n) begin
		state <= WF_INIT;
		rw_loop_count <= 0;
	end else begin
		case(state) /* synthesis syn_encoding = "one-hot" */
			WF_INIT: begin
				if(!i_wait_req) state <= IDLE;
			end
			
			IDLE: if(i_trigger) state <= WRITING;
			
			WRITING: begin
				if(done_writing) state <= READING;
			end
			
			READING: begin
				if(done_reading) state <= NEXT_LP;
			end
			
			NEXT_LP: begin
				rw_loop_count <= rw_loop_count + 1'b1;
				/* Change this in params.v: RW_MODE = (READING|WRITING);
					READING = write once, read forever.
					WRITING = write then read forever.
				*/
				state <= RW_MODE;
			end
			
			default: state <= IDLE;
		endcase
	end
// END CONTROL_STATE;

// BEGIN READ_STATE;
reg [7:0] read_state; /* synthesis syn_encoding = "one-hot" */
always @(posedge clk or negedge reset_n)
	if(!reset_n) begin
		read_state <= IDLE;
		read_address <= 0;
	end else begin
		case(read_state) /* synthesis syn_encoding = "one-hot" */
			IDLE: begin
				if(start_reading) read_state <= RW_WAIT_NOT_BUSY;
			end
			
			RW_WAIT_NOT_BUSY: if(!i_wait_req) begin
				read_state <= RW_WAIT_REQ_ACK;
				rd_n <= 0;
			end
			
			RW_WAIT_REQ_ACK: if(i_wait_req) begin
				read_state <= R_WAIT_VALID;
				rd_n <= 1;
			end
			
			R_WAIT_VALID:	if(i_valid) begin
				read_state <= RW_CHK_END_ADDR;
			end
			
			RW_CHK_END_ADDR: begin
				if(read_address == TARGET-1) begin
					read_state <= DONEROW;
					read_address <= 0;
				end else begin
					read_address <= read_address + 1;
					read_state <= RW_WAIT_NOT_BUSY;
				end
			end
			
			DONEROW: read_state <= (reading) ? read_state : IDLE;
			
			default: read_state <= IDLE;
		endcase
	end
// END READ_STATE;

// Error checking
always @(posedge clk or negedge reset_n)
	if(!reset_n) begin
		valid_pipe					 <= 0;
		o_read_error_count		 <= 0;
		read_return_data[15:0]	 <= 0;
		read_expected_data[15:0] <= 0;
		read_data_xor_ff[15:0]	 <= 0;
		read_error_ff				 <= 0;
	end else begin
		valid_pipe[7:0] <= { valid_pipe[6:0], i_valid };
		o_read_error_count <= o_read_error_count + read_error_ff;
		case(valid_pipe[3:0])
			'b0001: begin
				read_return_data[15:0]   <= i_data[15:0];	// FROM DRAM;
				read_expected_data[15:0] <= o_data[15:0]; // FROM LFSR+ADDRESS_XOR;
			end
			'b0010:read_data_xor_ff[15:0] <= read_data_xor[15:0];
			'b0100:read_error_ff <= read_error;
			'b1000:read_error_ff <= 0;
		endcase
	end
//
// BEGIN WRITE_STATE;
reg [7:0] write_state; /* synthesis syn_encoding = "one-hot" */
always @(posedge clk or negedge reset_n)
	if(!reset_n) begin
		write_state <= IDLE;
		write_address <= 0;
		//
	end else begin
		case(write_state) /* synthesis syn_encoding = "one-hot" */
			IDLE: if(start_writing) write_state <= RW_WAIT_NOT_BUSY;
			RW_WAIT_NOT_BUSY: if(!i_wait_req) begin
				write_state <= RW_WAIT_REQ_ACK;
				wr_n <= 0;
			end
			RW_WAIT_REQ_ACK: if(i_wait_req) begin
				write_state <= W_NOP;
				wr_n <= 1;
			end
			W_NOP: write_state <= RW_CHK_END_ADDR;
			RW_CHK_END_ADDR: if(write_address == TARGET-1) begin
					write_state <= DONEROW;
					write_address <= 0;
				end else begin
					write_address <= write_address + 1;
					write_state <= RW_WAIT_NOT_BUSY;
			end
			DONEROW: write_state <= (writing) ? write_state : IDLE;
			default: write_state <= IDLE;
		endcase
	end
// END WRITE_STATE;	
	
endmodule
