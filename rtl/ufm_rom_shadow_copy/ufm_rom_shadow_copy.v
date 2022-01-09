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
           output wire [00:0] complete_o,
           output wire [num_addr_bits-1:0] ufm_addr_o,
           output wire [num_addr_bits-1:0] ram_addr_o
       );

parameter num_words = 512;
localparam num_addr_bits = $clog2(num_words);
reg [num_addr_bits-1:0] wordcount;
reg [7:0] state; // synthesis syn_keep; syn_encode = "one-hot" //
assign complete_o = state[0];
reg rd;
assign ufm_read_o = rd;

always @(posedge clk or negedge reset_n)
    if(!reset_n) begin
    end else begin
    end

always @(posedge clk or negedge reset_n)
    if(!reset_n) begin
        state <= 'h2;
        wordcount <= 0;
    end else begin
        case(state)
            'h1:; //init complete
            'h2: begin
                rd<= 1;
                state <= 'h4;
            end
            'h4:
                if(ufm_wait_req_i) begin
                    state <= 'h8;
                end
            'h8:
                if(!ufm_wait_req_i) begin
                    rd <= 0;
                    state <= 'h10;
                end
            'h10:;
            default: state <= 'h2;
        endcase
    end
//


endmodule
