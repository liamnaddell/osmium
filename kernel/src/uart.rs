use core::fmt::Write;

const UART_RX: *const u8 = 0x10000000 as *const u8;
const UART_TX: *mut u8 = 0x10000000 as *mut u8;

pub const DEBUG: bool = false;

struct UART;

fn write_byte(byte: u8) {
    unsafe {
        *UART_TX = byte;
    }
}

impl Write for UART {
    fn write_str(&mut self, s: &str) -> core::fmt::Result {
        for c in s.bytes() {
            write_byte(c);
        }
        Ok(())
    }
}

pub fn print(arg: ::core::fmt::Arguments) {
    UART.write_fmt(arg).expect("failed to send by UART");
}

#[macro_export]
macro_rules! print {
    ($($arg:tt)*) => ($crate::uart::print(format_args!($($arg)*)));
}
#[macro_export]
macro_rules! dprint {
    ($($arg:tt)*) => (
        if $crate::uart::DEBUG {
            print!($($arg)*);
        }
    )
}

#[macro_export]
macro_rules! println {
    () => (print!("\n"));
    ($arg:expr) => (print!(concat!($arg, "\n")));
    ($fmt:expr, $($arg:tt)*) => (print!(concat!($fmt, "\n"), $($arg)*));
}
#[macro_export]
macro_rules! dprintln {
    ($($arg:tt)*) => (
        if $crate::uart::DEBUG {
            println!($($arg)*);
        }
    )
}

pub fn read_byte() -> u8 {
    unsafe { *UART_RX }
}
