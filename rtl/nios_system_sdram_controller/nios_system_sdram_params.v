// -----------------------------------------------------------------------------
// Copyright (c) 2021 All rights reserved
// -----------------------------------------------------------------------------
// Author : paul komurka (pawl) pawlex@gmail.com
// File   : sdram_init_reader_writer.v
// Create : 2021-12-12
// Revise : 1.0
// Editor : vim/quartus
// -----------------------------------------------------------------------------

// PARAMS
localparam TARGET = (1048576*4); // LOOP SIZE.
localparam XOR_MASK = 16'h5A5A;
localparam RW_MODE = WRITING;

// COMMON SM
localparam IDLE = 8'b0000_0001;
// CONTROL SM
localparam WF_INIT = 8'b0000_0010;
localparam WRITING = 8'b0000_0100;
localparam READING = 8'b0000_1000;
localparam NEXT_LP = 8'b0001_0000;
// RW SM
localparam RW_WAIT_NOT_BUSY 	= 8'b0000_0010;
localparam RW_WAIT_REQ_ACK 	= 8'b0000_0100;
localparam R_WAIT_VALID 		= 8'b0000_1000;
localparam W_NOP 					= 8'b0000_1000;
localparam RW_CHK_END_ADDR	   = 8'b0001_0000;
localparam DONEROW 				= 8'b1000_0000;
//
