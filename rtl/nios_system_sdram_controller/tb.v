`timescale 1ns/100ps

module tb();
reg reset_n=0;
reg clk=0;

initial begin
    forever #2 clk = ~clk;
end



reg i_cs, i_rd_n, i_wr_n;
reg [21:0] i_addr;
reg [15:0] i_data;
reg [1:0]  i_be_n;


initial begin
    reset_n = 0;
    i_addr = 22'h0;
    i_data = 16'h0;
    i_wr_n = 1;
    i_rd_n = 1;
    i_be_n = 2'b00; // Byte enables, Controls the data mask (DM, DQM) on the DRAM.  High = enabled. Low = disable

    #10;
    reset_n = 1;
    #25000
     wait(wait_req == 0);
    @(posedge clk);
    i_addr = 22'h00babe;
    i_data = 16'hd00d;
    i_wr_n = 0;
    wait(wait_req == 1);
    @(posedge clk)
     i_wr_n = 1;
    i_addr = 22'h3ffffe;
    i_data = 16'hfffe;
    #10000 $finish;
end

initial begin
    $dumpfile ("dump.vcd");
    $dumpvars();
end

/* SOME EXAMPLES
initial begin
    repeat(4) @(posedge clk);
    reset <= 0;
end

integer my_address 	= 0;
integer my_data 	= 0;

initial begin
    repeat(4) @(posedge clk);
    wait(wait_req == 0)
        repeat(100) @(posedge clk)
            while (my_address < 'h100) @(posedge clk) begin
                @(posedge clk);
            end
        #10000 $finish;
end

*/
wire [15:0] fifo_rrd;
wire [1:0]  dram_data_mask;
wire [1:0]  dram_bank_addr;
wire [11:0] dram_addr;
wire [15:0] dram_data;
wire cs, cke, cas, ras, we, valid;
wire wait_req;

nios_system_sdram SDRAM (
                      // inputs:
                      .az_addr(i_addr),		//22
                      .az_be_n(i_be_n),		//2
                      .az_data(i_data),		//16
                      .az_rd_n(i_rd_n),
                      .az_wr_n(i_wr_n),
                      .clk(clk),
                      .reset_n(reset_n),

                      // outputs:
                      .za_data(fifo_rrd), 		//16
                      .za_valid(valid),
                      .za_waitrequest(wait_req),
                      .zs_addr(dram_addr), 		//12
                      .zs_ba(dram_bank_addr),		//2
                      .zs_cas_n(cas),
                      .zs_cke(cke),
                      .zs_cs_n(cs),
                      .zs_dq(dram_data),	//16 b'z
                      .zs_dqm(dram_data_mask),		//2
                      .zs_ras_n(ras),
                      .zs_we_n(we)
                  );


endmodule

