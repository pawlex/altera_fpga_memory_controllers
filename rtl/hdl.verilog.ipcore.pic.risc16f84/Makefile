SRC=main.c
CC=/usr/local/bin/sdcc
FAMILY=pic14
PROC=16f84
OPTS=--use-non-free --no-extended-instructions --no-warn-non-free --stack-size 8 --less-pedantic --disable-warning 312
OPTS+=--out-fmt-ihx
#OPTS+=--out-fmt-s19

all: $(SRC:.c=.hex) rom

$(SRC:.c=.hex): $(SRC)
	$(CC) $(OPTS) -m$(FAMILY) -p$(PROC) $^

clean:
	rm -f $(SRC:.c=.asm) $(SRC:.c=.cod) $(SRC:.c=.hex) $(SRC:.c=.lst) $(SRC:.c=.o) $(SRC:.c=.hex) $(SRC:.c=.rom) out.vvp dump.vcd

rom:
	./intel2readmemh $(SRC:.c=.hex) > $(SRC:.c=.rom) || /bin/true

flash: all rom 
	./hex_mif.sh
	./asm.sh
	./prog.sh reconfigure

.PHONY: all clean
