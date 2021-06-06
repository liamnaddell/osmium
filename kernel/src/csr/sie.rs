use csr::{CSRRead, CSRWrite};
use utils;

pub struct SIE {
    pub mtimer: bool,
    pub software: bool,
}

impl CSRRead for SIE {
    fn read_csr() -> u32 {
        let result: u32;
        unsafe {
            llvm_asm!("csrrs $0, sie, x0"
                : "=&r"(result));
        }
        result
    }
    fn from_u32(x: u32) -> SIE {
        SIE {
            mtimer: utils::bit_range(x, 5, 6) == 1,
            software: utils::bit_range(x, 1, 2) == 1,
        }
    }
}
impl CSRWrite for SIE {
    fn read_and_write(val: u32) -> u32 {
        let result: u32;

        unsafe {
            llvm_asm!("csrrw $0, sie, $1"
                : "=&r"(result)
                :   "r"(val));
        }
        result
    }
    fn write_csr(val: u32) {
        unsafe {
            llvm_asm!("csrrw x0, sie, $0"
                :
                : "r"(val));
        }
    }

    fn bit_set(bitvec: u32) {
        println!("bitset{:x}", bitvec);
        unsafe {
            llvm_asm!("csrrs x0, sie, $0"
                :
                : "r"(bitvec));
        }
    }

    fn bit_clear(bitvec: u32) {
        unsafe {
            llvm_asm!("csrrc x0, sie, $0"
                :
                : "r"(bitvec));
        }
    }
    fn to_u32(&self) -> u32 {
        let mtimer = if self.mtimer { 1 << 5 } else { 0 };
        let software = if self.software { 1 << 1 } else { 0 };
        mtimer | software
    }
}

impl SIE {
    pub fn mtimer_on() {
        let v = SIE {
            mtimer: true,
            software: false,
        }
        .to_u32();
        SIE::bit_set(v);
    }
    pub fn software_on() {
        let v = SIE {
            mtimer: false,
            software: true,
        }
        .to_u32();
        SIE::bit_set(v);
    }
}
