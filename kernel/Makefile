BIN := "../tools/bin"

binary:
	mkdir -p bin
	mv _build.rs build.rs;\
	cargo xbuild --target riscv32ima-unknown-none-elf.json -Z unstable-options --out-dir bin;\
	mv build.rs _build.rs

.PHONY: binary

elf2bin: binary
	riscv32-unkown-elf-objcopy -O binary bin/osmium bin/osmium.bin
	python3 append_length.py

.PHONY: elf2bin

build: elf2bin
