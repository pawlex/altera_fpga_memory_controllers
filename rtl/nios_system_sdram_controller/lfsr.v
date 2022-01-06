/*
* Simple LFSR
* Paul Komurka
*/
module lfsr(clk, reset_n, out);
input clk;
input reset_n;
output reg [15:0] out;
parameter SEED = 16'hAAAA; // something more interesting?

always @(posedge clk or negedge reset_n) begin
    if(!reset_n) begin
        out <= SEED;
    end else begin
        out <= { out[3] ^ out[0], out[15:10], out[12] ^ out[14], out[8:1] };
    end
end
endmodule
