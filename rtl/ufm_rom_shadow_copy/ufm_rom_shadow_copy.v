/* Copy bytes from UFM ROM to RAM */
module ufm_rom_shadow_copy
       (
           input  wire [00:0] clk,
           input  wire [00:0] reset_n,
           input  wire [31:0] ufm_data_i,
           input  wire [00:0] ufm_wait_req_i,
           input  wire [00:0] ufm_valid_i,
           //
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
//
reg valid_ff;
reg [num_addr_bits-1:0] ram_addr_ff;
reg [num_addr_bits-1:0] wordcount;
reg [31:0] ram_data_ff;
reg [7:0] state; // synthesis syn_keep; syn_encode = "one-hot" //
reg rd, copy_done;


/* combi and static assigns */
assign ufm_burst_count_o = 1;
assign ufm_read_o = rd;
assign ufm_addr_o = wordcount;
assign ram_addr_o = ram_addr_ff;
assign complete_o = copy_done;
assign ram_byte_enable_o = 4'hF;
assign ram_write_enable_o = valid_ff;
assign ram_data_o = ram_data_ff;


// SM STATES
localparam IDLE	  = 'h01;
localparam WF_RDY = 2;
localparam WF_REQ = 4;
localparam WF_ACK = 8;
localparam WF_VALID = 'h10;
localparam WF_WORD_DONE = 'h20;
localparam INIT_CPL = 'h80;


always @(posedge clk or negedge reset_n)
    if(!reset_n) begin
        state <= IDLE;
        wordcount <= 0;
        copy_done <= 0;
        rd <= 0;
        //valid_ff <= 0;
    end else begin
        case(state)
            // Start condition.  wordcount < WORDCOUNT?
            IDLE:
                if(1) state <= WF_RDY;
            // Stall until bus is idle.
            WF_RDY:
                if(!ufm_wait_req_i)
                begin
                    rd <= 1;
                    state <= WF_ACK;
                end
            //
            WF_ACK:
            begin
                if(ufm_wait_req_i) state <= WF_VALID;
            end
            WF_VALID:
            begin
                if(!ufm_wait_req_i) rd <= 0;
                if(ufm_valid_i)
                    state <= WF_WORD_DONE;
            end
            WF_WORD_DONE:
                if(!ufm_valid_i)
                begin
                    state <= IDLE;
                    wordcount <= wordcount + 1'b1;
                end
            default: state <= IDLE;
        endcase
    end
//


// Handle latching the UFM data negedge of clk after valid goes high.
always @(negedge clk or negedge reset_n)
    if(!reset_n) begin
        ram_addr_ff <= 0;
        ram_data_ff <= 0;
        valid_ff <= 0;
    end else begin
        ram_addr_ff <= (!valid_ff) ? wordcount : ram_addr_ff; // don't latch the next address until we're done writing.
        ram_data_ff <= (ufm_valid_i) ? ufm_data_i : 'hFFFFFFFF;
        valid_ff <= ufm_valid_i;
    end
//


endmodule
    //always @(posedge clk or negedge reset_n)
    //    if(!reset_n) begin
    //    end else begin
    //	case(read_state) /* synthesis syn_encoding = "one-hot" */
    //		IDLE: begin
    //			if(start_reading) read_state <= RW_WAIT_NOT_BUSY;
    //		end
    //
    //		RW_WAIT_NOT_BUSY: if(!i_wait_req) begin
    //			read_state <= RW_WAIT_REQ_ACK;
    //			rd_n <= 0;
    //		end
    //
    //		RW_WAIT_REQ_ACK: if(i_wait_req) begin
    //			read_state <= R_WAIT_VALID;
    //			rd_n <= 1;
    //		end
    //
    //		R_WAIT_VALID:   if(i_valid) begin
    //			read_state <= RW_CHK_END_ADDR;
    //		end
    //
    //		RW_CHK_END_ADDR: begin
    //			if(read_address == TARGET-1) begin
    //				read_state <= DONEROW;
    //				read_address <= 0;
    //			end else begin
    //				read_address <= read_address + 1;
    //				read_state <= RW_WAIT_NOT_BUSY;
    //			end
    //		end
    //
    //		DONEROW: read_state <= (reading) ? read_state : IDLE;
    //
    //		default: read_state <= IDLE;
    //	endcase
    //end
