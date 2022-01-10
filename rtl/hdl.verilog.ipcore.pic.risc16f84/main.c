#include <pic16regs.h>
#include <stdint.h>
#include <stdio.h>
//#include <unistd.h>

void halt(void)
{
    while(1)
    {
        __asm nop __endasm;
    }
}

#define STRIDE 0x1
#define MAXVAL 0xFF

void nopsleep(uint16_t target)
{
	for(uint16_t i=target; i>0; i--)
	{
		__asm nop __endasm;
	}
}

void io_data_write(uint8_t val, uint16_t sleep)
{
    EEDATA = val;
    if(sleep)
    {
        nopsleep(sleep);
    }
}

void led_test(void)

{
    //io_data_write(0xff, 0xF000);
    //io_data_write(0x00, 0xF000);
    io_data_write(0x55, 0xF000);
    io_data_write(0xAA, 0xF000);
}

void led_scan(uint16_t sleep)
{
   // uint8_t i=1;
   // for(uint8_t j=64; j>0; j--)
   // {
   //     i=i<<1;
   //     io_data_write(i, sleep);
   // }
    uint8_t shift = 1;
    do
    {
       shift = shift << 1;
       io_data_write(shift, 0x1000);
    } while (shift < 0x80);
    do
    {
       shift = shift >> 1;
       io_data_write(shift, 0x1000);
    } while (shift > 0x1);
}

void led_scan_noshift(uint16_t sleep)
{
    io_data_write(0x01, sleep);
    io_data_write(0x02, sleep);
    io_data_write(0x04, sleep);
    io_data_write(0x08, sleep);
    io_data_write(0x10, sleep);
    io_data_write(0x20, sleep);
    io_data_write(0x40, sleep);
    io_data_write(0x80, sleep);
    io_data_write(0x40, sleep);
    io_data_write(0x20, sleep);
    io_data_write(0x10, sleep);
    io_data_write(0x08, sleep);
    io_data_write(0x04, sleep);
    io_data_write(0x02, sleep);
    io_data_write(0x01, sleep);
}

void main(void)
{
	while(1)
	{
	    //led_test();
        led_scan(0x1000);
        //led_scan_noshift(0x800);
	}

    halt();
}

/* Paul Komurka
 * test file for the soft-core pic16f84 (clk2x)
 * with ports A/B removed and replaced with a 
 * GPIO BUS.
 *
 * IO BUS:
 * ADDRESS [15:0] = { PORTB,PORTA }
 * DATA    [7:0 ] =   EEDATA
 */


// LOAD GPIO RAM (RAM BACKED PORT)
// WITH DATA = ADDRESS
// for(uint16_t i=0;i<MAXVAL;i=i+STRIDE)
// {
//     //PORTA = i & 0xff; 
//     //PORTB = ((i >> 8) & 0xff);
//     EEDATA = i & 0xff;
// 	nopsleep();
// }
//
// READ BACK AND COMPARE
//for(i=0;i<MAXVAL;i=i+STRIDE)
//{
//    PORTA = i & 0xff; 
//    PORTB = ((i >> 8) & 0xff);
//    
//    // DEADLOOP IF MISMATCH
//    if(EEDATA != (i & 0xff))
//    {
//        halt();
//    }
//}
