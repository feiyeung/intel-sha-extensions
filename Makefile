OBJ_C := intel_sha_extensions_sha1_intrinsic.o intel_sha_extensions_sha256_intrinsic.o
OBJ_ASM := intel_sha_extensions_sha1_assembly.o intel_sha_extensions_sha256_assembly.o
override CFLAGS += -msha -msse4

all: assembly intrinsics

clean:
	rm -f $(OBJ_C) $(OBJ_ASM) intrinsics

assembly: $(OBJ_ASM)
	$(CC) -o assembly main.c $(OBJ_ASM) 

intrinsics: $(OBJ_C)
	$(CC) -o intrinsics main.c $(OBJ_C)

$(OBJ_C): %.o: %.c     

$(OBJ_ASM): %.o: %.asm
	yasm $< -f elf64 -X gnu -g dwarf2 -o $@

