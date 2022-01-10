`timescale 1ns/100ps

module tb();
reg reset_n=0;
reg clk=0;

initial begin
    forever #10 clk = ~clk;
end

initial begin
    reset_n = 0;
    ufm_wait_req_i = 0;
    ufm_valid_i = 0;
    #30;
    reset_n = 1;
    #600 $finish;
end

initial begin
    $dumpfile ("dump.vcd");
    $dumpvars();
end

// Emulate the Avalon_mm behavior.
initial begin
    forever wait(ufm_read_o) begin
        ufm_wait_req_i = #3 1;
        #60 ufm_wait_req_i = 0;
        repeat(5) @(posedge clk);
        ufm_valid_i =1;
        repeat(1) @(posedge clk);
        ufm_valid_i = 0;
    end

end

always @(posedge clk or negedge reset_n)
    if(!reset_n) ufm_data_i <= 31'h55555555;
    else if(ufm_valid_i) begin
        ufm_data_i <= ~ufm_data_i;
    end

/* SOME EXAMPLES */
//initial begin
//    repeat(4) @(posedge clk);
//    reset <= 0;
//end
//
//
//integer my_address = 0;
//initial begin
//    repeat(4) @(posedge clk);
//    wait(wait_req == 0)
//        repeat(100) @(posedge clk)
//            while (my_address < 'h100) @(posedge clk) begin
//                @(posedge clk);
//            end
//        #10000 $finish;
//end

top
    dut
    (
        .clk(clk),
        .reset_n(reset_n)
    );

parameter num_words = 512;
localparam num_addr_bits = $clog2(num_words);
reg [num_addr_bits-1:0] wordcount;

reg [31:0] ufm_data_i;
reg [00:0] ufm_wait_req_i;
reg [00:0] ufm_valid_i;
wire [31:0] ram_data_o;
wire [01:0] ufm_burst_count_o;
wire [03:0] ram_byte_enable_o;
wire [00:0] ram_write_enable_o;
wire [00:0] ufm_read_o;
wire [00:0] complete;
wire [num_addr_bits-1:0] ufm_addr_o;
wire [num_addr_bits-1:0] ram_addr_o;

ufm_rom_shadow_copy dma
                    (
                        .clk(clk),
                        .reset_n(reset_n),
                        .ufm_data_i(ufm_data_i),
                        .ufm_wait_req_i(ufm_wait_req_i),
                        .ufm_valid_i(ufm_valid_i),
                        .ram_data_o(),
                        .ufm_burst_count_o(),
                        .ram_byte_enable_o(),
                        .ram_write_enable_o(),
                        .ufm_read_o(ufm_read_o),
                        .complete_o(),
                        .ufm_addr_o(),
                        .ram_addr_o()
                    );

endmodule

