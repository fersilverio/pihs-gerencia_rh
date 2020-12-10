program = ger_rh_pt2
dl = -dynamic-linker
lib = /lib/ld-linux.so.2

all: compile link run
debug: compile link gdb


compile:
	as -32 -gstabs $(program).s -o $(program).o

link:
	ld -m elf_i386 $(program).o -l c $(dl) $(lib) -o $(program)

gdb:
	gdb $(program)

run:
	./$(program)
