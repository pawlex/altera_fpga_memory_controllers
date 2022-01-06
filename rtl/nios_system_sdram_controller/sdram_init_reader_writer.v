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
	output [15:0] o_debug
);
//
reg [21:0] read_address;
reg [21:0] write_address;
reg [15:0] read_return_data;
reg [15:0] read_error_count;
assign o_be_n = 2'h0;
assign o_rd_n = rd_n;
assign o_wr_n = wr_n;
assign o_addr = (state == READING) ? read_address : write_address;
assign o_data = write_address;
assign o_ram_reading = reading;
assign o_ram_writing = writing;
reg rd_n, wr_n;

// COMMON SM
localparam IDLE    				= 8'b0000_0001;
//localparam TOSS_FIRST_READ 	= 8'b0010_0000;

// MAIN SM_
localparam WF_INIT = 8'b0000_0010;
localparam WRITING = 8'b0000_0100;
localparam READING = 8'b0000_1000;
// RW SM
localparam RW_WAIT_NOT_BUSY 	= 8'b0000_0010;
localparam RW_WAIT_REQ_ACK 	= 8'b0000_0100;
localparam R_WAIT_VALID 		= 8'b0000_1000;
localparam W_NOP 					= 8'b0000_1000;
localparam RW_CHK_END_ADDR	   = 8'b0001_0000;
localparam DONEROW 				= 8'b1000_0000;


//localparam TARGET  = 256; // same page.
localparam TARGET = (1048576*4); // 2 full banks

wire start_reading; assign start_reading = (state == READING && read_state  == IDLE);
wire start_writing; assign start_writing = (state == WRITING && write_state == IDLE);
assign o_error = (read_error_count > 0);

`ifdef INITIAL_DEBUG
	assign o_debug[7:0] = {read_state[2:0],write_state[2:0],state[1:0]};
	assign o_debug[11:8] = {o_rd_n, o_wr_n, i_wait_req,i_trigger};
	assign o_debug[15:12] = read_error_count[3:0];
`endif

`define DATA_DEBUG
`ifdef DATA_DEBUG
	//assign o_debug[7:0]  = read_address_ff[7:0];
	//assign o_debug[15:8] = read_return_data[7:0];
	//assign o_debug[7:0]  = read_address[7:0];
	//assign o_debug[15:8] = i_data[7:0];
	//assign o_debug[15:0] = {write_state[3:0],read_state[5:0], state[5:0]};
	//assign o_debug[7:0]  = {writet_state[2:0]};
	//assign o_debug[5:0] = { o_addr[5:0] };
	//assign o_debug[11:6] = { read_return_data[5:0] };
	//assign o_debug[15:12] = { read_error_count[3:0] };
	assign o_debug[15:8] = { o_addr[21:18], o_addr[3:0] };
	assign o_debug[5:0]  = { o_rd_n, o_wr_n, i_wait_req, i_valid, reading, writing };
	wire reading; assign reading = (state == READING);
	wire writing; assign writing = (state == WRITING);
	
`endif

// CONTROL STATE MACHINE
reg [7:0] state; /* synthesis syn_encoding = "one-hot" */
always @(posedge clk or negedge reset_n)
	if(!reset_n) begin
		state <= WF_INIT;
	end else begin
		case(state) /* synthesis syn_encoding = "one-hot" */
			WF_INIT: begin
				if(!i_wait_req) state <= IDLE;
			end
			IDLE: if(i_trigger) state <= WRITING;
			WRITING: begin
				if(write_state == DONEROW) state <= READING;
			end
			READING: begin
				if(read_state == DONEROW) state <= IDLE;
			end
			
			//TOSS_FIRST_READ: begin
			//	if(i_valid) state <= IDLE;
			//end
			
			default: state <= IDLE;
		endcase
	end
//

// READER STATE MACHINE
reg [7:0] read_state; /* synthesis syn_encoding = "one-hot" */
always @(posedge clk or negedge reset_n)
	if(!reset_n) begin
		read_state <= IDLE;
		read_return_data <= 0;
		read_address <= 0;
		read_error_count <= 0;
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
				if(i_data[15:0] != read_address[15:0]) read_error_count <= read_error_count + 1'b1;
				read_return_data[15:0] <= i_data[15:0];
				if(read_address == TARGET-1) begin
					read_state <= DONEROW;
					read_address <= 0;
				end else begin
					read_address <= read_address + 1;
					read_state <= RW_WAIT_NOT_BUSY;
				end
			end
			
			DONEROW: read_state <= (state == READING) ? read_state : IDLE;
			
			//TOSS_FIRST_READ: begin
			//if(state == TOSS_FIRST_READ)
			//	if(i_wait_req) begin 
			//		rd_n <= 1;
			//		read_state <= IDLE;
			//	end else rd_n <= 0;
			//end

			default: read_state <= IDLE;
		endcase
	end
//


// WRITER STATE MACHINE
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
			DONEROW: write_state <= (state == WRITING) ? write_state : IDLE;
			default: write_state <= IDLE;
		endcase
	end
//


endmodule
