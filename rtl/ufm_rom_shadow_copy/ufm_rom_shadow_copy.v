/* Copy bytes from UFM ROM to RAM */
module ufm_rom_shadow_copy 
(
	input  wire [00:0] clk,
	input  wire [00:0] reset_n,
	input  wire [31:0] ufm_data_i,
	input  wire [00:0] ufm_wait_req_i,
	input  wire [00:0] ufm_valid_i,
	output wire [31:0] ram_data_o,
	output wire [01:0] ufm_burst_count_o,
	output wire [03:0] ram_byte_enable_o,
	output wire [00:0] ram_write_enable_o,
	output wire [00:0] ufm_read_o,
	output wire [00:0] complete,
	output wire [num_addr_bits-1:0] ufm_addr_o,
	output wire [num_addr_bits-1:0] ram_addr_o,

);

parameter num_words = 512;
localparam num_addr_bits = $clog2(num_words);
reg [num_addr_bits-1:0] wordcount;
reg [7:0] state; // synthesis syn_keep; syn_encode = "one-hot" //

assign complete = state[0];

always @(posedge clk or negedge reset_n)
	if(!reset_n) begin
		state <= '1;
		wordcount <= 0;
		case(state)
			'h1:; //init complete
			'h2:;
			'h1:;
			'h2:;
			'h1:;
			'h2:;
			'h1:;
			'h2:;
			'h1:;
			'h2:;
			'h1:;
			'h2:;
			default: state <= 'h1;
		endcase
	end
//


endmodule
/*
wire [15:0] ufm_rd_addr;
wire [01:0] ufm_burst_count;
wire ufm_rd, ufm_rd_waitreq, ufm_rd_valid;
wire [31:0] ufm_rd_data; -> pic_0_rom_wr_data;
wire [08:0] pic_0_rom_wr_addr;
wire [03:0] pic_0_rom_wr_be;
wire [00:0] pic_0_rom_wr_we;
*/
