extern crate cc;

use cc::Build;
use std::env;
use std::error::Error;
use std::path::Path;
use std::process::Command;

fn main() -> Result<(), Box<Error>> {
    Build::new().file("boot.s").flag("-mabi=ilp32").compile("asm");

    Command::new("riscv32-unknown-elf-objcopy")
        .args(&["-O binary"])
        .args(&["bin/osmium", "bin/osmium.bin"])
        .status()?;

    Ok(())
}
