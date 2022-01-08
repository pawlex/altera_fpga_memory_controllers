/* This is a Verilog template for use with the BeMicro MAX 10 development kit */
/* It is used for showing the IO pin names and directions                     */
/* Ver 0.2 10.07.2014                                                         */

/* NOTE: A VHDL version of this template is also provided with this design    */
/* example for users that prefer VHDL. This BeMicro_MAX10_top.v file would    */
/* need to be removed from the project and replaced with the                  */
/* BeMicro_MAX10_top.vhd file to switch to the VHDL template.                 */

/* The signals below are documented in the "BeMicro MAX 10 Getting Started    */
/* User Guide."  Please refer to that document for additional signal details. */

`define ENABLE_CLOCK_INPUTS
//`define ENABLE_DAC_SPI_INTERFACE
//`define ENABLE_TEMP_SENSOR
//`define ENABLE_ACCELEROMETER
//`define ENABLE_SDRAM
//`define ENABLE_SPI_FLASH
//`define ENABLE_MAX10_ANALOG
`define ENABLE_PUSHBUTTON
`define ENABLE_LED_OUTPUT
//`define ENABLE_EDGE_CONNECTOR
`define ENABLE_HEADERS
//`define ENABLE_GPIO_J3
`define ENABLE_GPIO_J4
//`define ENABLE_PMOD
`define ENABLE_CHIPSCOPE
`define DESIGN_LEVEL_RESET
`define ENABLE_PLL_0
`define ENABLE_PLL_1
//`define ENABLE_UFM
`define PIC14_16F

module BeMicro_MAX10_top (

`ifdef	ENABLE_DAC_SPI_INTERFACE
	/* DAC, 12-bit, SPI interface (AD5681) */
	output AD5681R_LDACn,
	output AD5681R_RSTn,
	output AD5681R_SCL,
	output AD5681R_SDA,
	output AD5681R_SYNCn,
`endif	

`ifdef ENABLE_TEMP_SENSOR 
	/* Temperature sensor, I2C interface (ADT7420) */
	// Voltage Level 3.3V
	input ADT7420_CT,		
	input ADT7420_INT,		
	inout ADT7420_SCL,		
	inout ADT7420_SDA,
`endif

`ifdef ENABLE_ACCELEROMETER	
	/* Accelerometer, 3-Axis, SPI interface (ADXL362)*/
	// Voltage Level 3.3V
	output ADXL362_CS,
	input ADXL362_INT1,
	input ADXL362_INT2,
	input ADXL362_MISO,
	output ADXL362_MOSI,
	output ADXL362_SCLK,
`endif	

`ifdef ENABLE_SDRAM
	/* 8MB SDRAM, ISSI IS42S16400J-7TL SDRAM device */
	// Voltage Level 3.3V
	output [11:0] SDRAM_A,
	output [1:0] SDRAM_BA,
	output SDRAM_CASn,
	output SDRAM_CKE,
	output SDRAM_CLK,
	output SDRAM_CSn,
	inout [15:0] SDRAM_DQ,
	output SDRAM_DQMH,
	output SDRAM_DQML,
	output SDRAM_RASn,
	output SDRAM_WEn,
`endif

`ifdef ENABLE_SPI_FLASH	
	/* Serial SPI Flash, 16Mbit, Micron M25P16-VMN6 */
	// Voltage Level 3.3V
	input SFLASH_ASDI,
	input SFLASH_CSn,
	inout SFLASH_DATA,
	inout SFLASH_DCLK,
`endif	

`ifdef ENABLE_MAX10_ANALOG
	/* MAX10 analog inputs */
	// Voltage Level 3.3V
	input [7:0] AIN,
`endif

`ifdef ENABLE_PUSHBUTTON	
	/* pushbutton switch inputs */
	// Voltage Level 3.3V
	input [4:1] PB,
`endif	

`ifdef ENABLE_LED_OUTPUT
	/* LED outputs */
	// Voltage Level 3.3V
	output [8:1] USER_LED,
`endif	

`ifdef ENABLE_EDGE_CONNECTOR
	/* BeMicro 80-pin Edge Connector */ 
	// Voltafe Level 3.3V
	inout EG_P1,
	inout EG_P10,
	inout EG_P11,
	inout EG_P12,
	inout EG_P13,
	inout EG_P14,
	inout EG_P15,
	inout EG_P16,
	inout EG_P17,
	inout EG_P18,
	inout EG_P19,
	inout EG_P2,
	inout EG_P20,
	inout EG_P21,
	inout EG_P22,
	inout EG_P23,
	inout EG_P24,
	inout EG_P25,
	inout EG_P26,
	inout EG_P27,
	inout EG_P28,
	inout EG_P29,
	inout EG_P3,
	inout EG_P35,
	inout EG_P36,
	inout EG_P37,
	inout EG_P38,
	inout EG_P39,
	inout EG_P4,
	inout EG_P40,
	inout EG_P41,
	inout EG_P42,
	inout EG_P43,
	inout EG_P44,
	inout EG_P45,
	inout EG_P46,
	inout EG_P47,
	inout EG_P48,
	inout EG_P49,
	inout EG_P5,
	inout EG_P50,
	inout EG_P51,
	inout EG_P52,
	inout EG_P53,
	inout EG_P54,
	inout EG_P55,
	inout EG_P56,
	inout EG_P57,
	inout EG_P58,
	inout EG_P59,
	inout EG_P6,
	inout EG_P60,
	inout EG_P7,
	inout EG_P8,
	inout EG_P9,
	input EXP_PRESENT,
	output RESET_EXPn,
`endif

`ifdef ENABLE_HEADERS	
	/* Expansion headers (pair of 40-pin headers) */
	// Voltage Level 3.3V
	inout GPIO_01,
	inout GPIO_02,
	inout GPIO_03,
	inout GPIO_04,
	inout GPIO_05,
	inout GPIO_06,
	inout GPIO_07,
	inout GPIO_08,
	inout GPIO_09,
	inout GPIO_10,
	inout GPIO_11,
	inout GPIO_12,
	inout GPIO_A,
	inout GPIO_B,
	inout I2C_SCL,
	inout I2C_SDA,
`endif

`ifdef ENABLE_GPIO_J3
	//The following group of GPIO_J3_* signals can be used as differential pair 
	//receivers as defined by some of the Terasic daughter card that are compatible 
	//with the pair of 40-pin expansion headers. To use the differential pairs, 
	//there are guidelines regarding neighboring pins that must be followed.  
	//Please refer to the "Using LVDS on the BeMicro MAX 10" document for details.
	// Voltage Level 3.3V
	inout GPIO_J3_15,
	inout GPIO_J3_16,
	inout GPIO_J3_17, 
	inout GPIO_J3_18,
	inout GPIO_J3_19,
	inout GPIO_J3_20,
	inout GPIO_J3_21,	
	inout GPIO_J3_22,
	inout GPIO_J3_23,	
	inout GPIO_J3_24,
	inout GPIO_J3_25,	
	inout GPIO_J3_26,
	inout GPIO_J3_27,	
	inout GPIO_J3_28,
	inout GPIO_J3_31,	
	inout GPIO_J3_32,
	inout GPIO_J3_33,	
	inout GPIO_J3_34,
	inout GPIO_J3_35,	
	inout GPIO_J3_36,
	inout GPIO_J3_37,	
	inout GPIO_J3_38,
	inout GPIO_J3_39,	
	inout GPIO_J3_40,

`endif

`ifdef ENABLE_GPIO_J4
	//The following group of GPIO_J4_* signals can be used as true LVDS transmitters 
	//as defined by some of the Terasic daughter card that are compatible 
	//with the pair of 40-pin expansion headers. To use the differential pairs, 
	//there are guidelines regarding neighboring pins that must be followed.  
	//Please refer to the "Using LVDS on the BeMicro MAX 10" document for details.
	// Voltage Level 3.3V
	inout GPIO_J4_11,
	inout GPIO_J4_12,
	inout GPIO_J4_13,
	inout GPIO_J4_14,
	inout GPIO_J4_15, 
	inout GPIO_J4_16, 
	inout GPIO_J4_19,
	inout GPIO_J4_20,
	inout GPIO_J4_21,
	inout GPIO_J4_22, 
	inout GPIO_J4_23,
	inout GPIO_J4_24, 
	inout GPIO_J4_27,
	inout GPIO_J4_28, 
	inout GPIO_J4_29,
	inout GPIO_J4_30, 
	inout GPIO_J4_31,
	inout GPIO_J4_32, 
	inout GPIO_J4_35,
	inout GPIO_J4_36, 
	inout GPIO_J4_37,
	inout GPIO_J4_38, 
	inout GPIO_J4_39,
	inout GPIO_J4_40, 
`endif

`ifdef ENABLE_PMOD	
	/* PMOD connectors */
	//Voltage Level 3.3V
	inout [3:0] PMOD_A,
	inout [3:0] PMOD_B,
	inout [3:0] PMOD_C,
	inout [3:0] PMOD_D,
`endif

/* Clock inputs, SYS_CLK = 50MHz, USER_CLK = 24MHz */	
`ifdef ENABLE_CLOCK_INPUTS
	input SYS_CLK,  // 50MHz oscillator at position Y1.
	input USER_CLK // USER_CLK oscillator is not connected. Postition Y2.
`endif
);

`ifdef ENABLE_CHIPSCOPE
	`define DEBUG_LO { GPIO_08, GPIO_07, GPIO_06,    GPIO_05,    GPIO_04,    GPIO_03,    GPIO_02, GPIO_01 }
	`define DEBUG_HI { GPIO_11, GPIO_12, GPIO_J4_13, GPIO_J4_14, GPIO_J4_11, GPIO_J4_12, GPIO_10, GPIO_09 }
`endif

`ifdef ENABLE_CHIPSCOPE
	wire [15:0] DEBUG; assign {`DEBUG_HI,`DEBUG_LO} = DEBUG[15:0];
`endif

`ifdef DESIGN_LEVEL_RESET
	/* TODO:  Find out how to use Altera GSR */
	parameter SYS_CLK_FREQ = 'd50_000_000;
	//`ifdef ENABLE_PLL_0
	//	assign reset_n = (user_reset_cpl & pll_0_lock);
	//`else
	//	assign reset_n = user_reset_cpl;
	//`endif
	assign reset_n = 
	 (user_reset_cpl `ifdef ENABLE_PLL_0 & pll_0_lock `endif `ifdef ENABLE_PLL_1 & pll_1_lock `endif);
	
	wire reset,reset_n;assign reset = ~reset_n;
	reg [25:0] user_reset_cntr;reg [0:0] user_reset_cpl;
	wire user_reset_button; assign user_reset_button = ~PB[1];
	//wire user_debug_counter; assign user_debug_counter = ~PB[2];

	always @(posedge SYS_CLK or posedge user_reset_button) begin
		if(user_reset_button) begin
			user_reset_cntr <= 0;
			user_reset_cpl  <= 0;
		end 
		else begin
			if(user_reset_cntr == SYS_CLK_FREQ/1000) begin
				user_reset_cpl <= 1;
			end else begin
				user_reset_cntr <= user_reset_cntr + 1'b1;
				user_reset_cpl <= 0;
			end
		end
	end
`endif

`ifdef ENABLE_PLL_0
wire clk120p0, clk16p0, clk8p0, clk4p0, clk2p0, pll_0_lock;
pll_0	pll_0_inst (
	.inclk0 ( SYS_CLK ),
	.c0 ( clk120p0 ),
	.c1 ( clk16p0 ),
	.c2 ( clk8p0 ),
	.c3 ( clk4p0 ),
	.c4 ( clk2p0 ),
	.locked ( pll_0_lock )
	);
`endif

`ifdef ENABLE_PLL_1
wire clk125p0, clk100p0, clk25p0, clk10p0, clk1p0, pll_1_lock;
pll_1	pll_1_inst (
	.inclk0 ( SYS_CLK ),
	.c0 ( clk125p0 ),
	.c1 ( clk100p0 ),
	.c2 ( clk25p0 ),
	.c3 ( clk10p0 ),
	.c4 ( clk1p0 ),
	.locked ( pll_1_lock )
	);
`endif

/* LED SWAPPING and assigns */
assign USER_LED[8:1] = ~pic_o_io_wr_data[7:0];
//reg [7:0] led_o; assign USER_LED[8:1] = ~led_o;
//always @* begin
//	led_o[7]= reset_n; // Assert LED while device is in RESET
//	led_o[6]= o_ram_error;
//	led_o[5]= o_ram_reading;
//	led_o[4]= o_ram_writing;
//	led_o[3]= o_read_error_count[3];
//	led_o[2]= o_read_error_count[2];
//	led_o[1]= o_read_error_count[1];
//	led_o[0]= o_read_error_count[0];
//end

`ifdef ENABLE_SDRAM
assign SDRAM_CLK = clk120p0;
//assign SDRAM_CLK = SYS_CLK;
wire i_rd_n, i_wr_n, o_valid, o_wait_req, o_ram_error, o_ram_reading, o_ram_writing;
wire [15:0] i_data, o_data, o_read_error_count;
wire [21:0] i_addr;
wire [1:0]  i_be_n; // Same as DRAM Data Mask
sdram_init_reader_writer mem_init (
	.clk(SDRAM_CLK),
	.reset_n(reset_n),
	.i_valid(o_valid),
	.i_wait_req(o_wait_req),
	.i_data(o_data),
	.i_trigger(1'b1),
	.o_rd_n(i_rd_n),
	.o_wr_n(i_wr_n),
	.o_data(i_data),
	.o_addr(i_addr),
	.o_be_n(i_be_n),
	.o_error(o_ram_error),
	.o_ram_reading(o_ram_reading),
	.o_ram_writing(o_ram_writing),
	.o_read_error_count(o_read_error_count),
	.o_debug(DEBUG)
);
nios_system_sdram sdram_0 (
	// inputs:
	.az_addr(i_addr),		//22
	.az_be_n(i_be_n),		//2
	.az_data(i_data),		//16
	.az_rd_n(i_rd_n),
	.az_wr_n(i_wr_n),
	.clk(SDRAM_CLK),
	.reset_n(reset_n),
	// outputs:
	.za_data(o_data), 		//16
	.za_valid(o_valid),
	.za_waitrequest(o_wait_req),
	.zs_addr(SDRAM_A), 		//12
	.zs_ba(SDRAM_BA),		//2
	.zs_cas_n(SDRAM_CASn),
	.zs_cke(SDRAM_CKE),
	.zs_cs_n(SDRAM_CSn),
	.zs_dq(SDRAM_DQ),	//16 b'z
	.zs_dqm({SDRAM_DQMH,SDRAM_DQML}),		//2
	.zs_ras_n(SDRAM_RASn),
	.zs_we_n(SDRAM_WEn)
	);
`endif

`ifdef PIC14_16F
wire PIC_CLK, PIC_2X_CLK;
assign PIC_CLK = clk2p0;
assign PIC_2X_CLK = ~clk4p0; // RAM/ROM should be latched on the falling edge. S&H
/* 8/~16 on same PLL works */
/* 25/~50(sys) works */
/* 50(sys)/100 works */


assign DEBUG[15:12] = { PIC_CLK, pic_0_ram_we, pic_0_io_rd, pic_0_io_wr};
//assign DEBUG[5:0]   = pic_0_io_data[5:0];
//assign DEBUG[11:6]  = pic_o_io_wr_data[5:0];
assign DEBUG[11:08] = pic_0_ram_read_data[3:0];
assign DEBUG[07:04] = pic_0_rom_data_byte_swapped[3:0];
assign DEBUG[03:00] = pic_0_rom_address[3:0];
wire [15:0] pic_0_rom_data;
wire [12:0] pic_0_rom_address; // 2M9K, so really only [9:0];
wire [07:0] pic_0_ram_write_data;
wire [07:0] pic_0_ram_read_data;
wire [09:0] pic_0_ram_address; // 1M9K, PIC can only address 9 bits.
wire [15:0] pic_0_io_address;
wire [07:0] pic_0_io_data;
wire pic_0_ram_we, pic_0_io_rd, pic_0_io_wr;

/* 
	SDCC and gutils produces 16 byte intel-hex format,
	which is byte-swapped and byte aligned.
*/

wire [15:0] pic_0_rom_data_byte_swapped;
assign pic_0_rom_data_byte_swapped = { pic_0_rom_data[7:0], pic_0_rom_data[15:8] };

// Latch the IO write data
// DFF on PIC_CLK because PIC design uses tri-state
// on IO data.  Quartus doesn't like this.
// Converted the fan-out from the tri-state buffer "<name>" 
// to the node "<name>" into an OR gate (ID: 13047)
reg [7:0] pic_o_io_wr_data;
always @(negedge PIC_CLK or negedge reset_n) 
	if(!reset_n) pic_o_io_wr_data <= 0;
	else if(pic_0_io_wr) pic_o_io_wr_data <= pic_0_io_data;
//
pic_0_rom // Stored in 32-byte intel-hex format.
	pic_0_rom_inst 
	(
		.address ( pic_0_rom_address ),
		.clock ( PIC_2X_CLK ),
		.q ( pic_0_rom_data )
	);
	
pic_0_ram	
	pic_0_ram_inst 
	(
		.address ( pic_0_ram_address ),
		.data ( pic_0_ram_write_data ),
		.inclock ( PIC_2X_CLK ),
		.outclock ( PIC_2X_CLK ),
		.wren ( pic_0_ram_we ),
		.q ( pic_0_ram_read_data )
	);

risc16f84_clk2x 
	pic_0
	(
		.prog_dat_i(pic_0_rom_data_byte_swapped), // [13:0] ROM read data
		.prog_adr_o(pic_0_rom_address),           // [12:0] ROM address
		.ram_dat_i(pic_0_ram_read_data),            // [7:0] RAM read data
		.ram_dat_o(pic_0_ram_write_data),            // [7:0] RAM write data
		.ram_adr_o(pic_0_ram_address),            // [8:0] RAM address; ram_adr[8:7] indicates RAM-BANK
		.ram_we_o(pic_0_ram_we),             // RAM write strobe (H active)
		.aux_adr_o(pic_0_io_address),            // [15:0] Auxiliary address bus
		.aux_dat_io(pic_0_io_data),           // [7:0] Auxiliary data bus (tri-state bidirectional)
		.aux_we_o(pic_0_io_wr),             // Auxiliary write strobe (H active)
		.aux_re_o(pic_0_io_rd),             // Auxiliary read  strobe (H active) PK
		.int0_i(1'b0),               // PORT-B(0) INT
		.reset_i(reset),              // Power-on reset (H active)
		// TODO: Move both PIC and 2X to same PLL.
		.clk_en_i(1'b1),             // Clock enable for all clocked logic
		.clk_i(PIC_CLK)                 // Clock input
	);
//
`endif 


`ifdef ENABLE_UFM
// ("oc_flash_onchip_flash_0.hex") //

 oc_flash ufm0 (
        .clock                   (clk100p0),
        .reset_n                 (reset_n),
        .avmm_data_addr          (), //16
        .avmm_data_read          (),
        .avmm_data_writedata     (), //32
        .avmm_data_write         (), 
        .avmm_data_readdata      (), //32,o
        .avmm_data_waitrequest   (), //o
        .avmm_data_readdatavalid (), //o
        .avmm_data_burstcount    (), //2
        .avmm_csr_addr           (),
        .avmm_csr_read           (),
        .avmm_csr_writedata      (), //32
        .avmm_csr_write          (),
        .avmm_csr_readdata       ()  //32,o
    );
/*
module oc_flash (
		input  wire        clock,                   //    clk.clk
		input  wire        avmm_csr_addr,           //    csr.address
		input  wire        avmm_csr_read,           //       .read
		input  wire [31:0] avmm_csr_writedata,      //       .writedata
		input  wire        avmm_csr_write,          //       .write
		output wire [31:0] avmm_csr_readdata,       //       .readdata
		input  wire [15:0] avmm_data_addr,          //   data.address
		input  wire        avmm_data_read,          //       .read
		input  wire [31:0] avmm_data_writedata,     //       .writedata
		input  wire        avmm_data_write,         //       .write
		output wire [31:0] avmm_data_readdata,      //       .readdata
		output wire        avmm_data_waitrequest,   //       .waitrequest
		output wire        avmm_data_readdatavalid, //       .readdatavalid
		input  wire [1:0]  avmm_data_burstcount,    //       .burstcount
		input  wire        reset_n                  // nreset.reset_n
	);
*/
`endif

endmodule
