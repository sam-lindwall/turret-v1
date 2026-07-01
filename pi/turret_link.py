#!/usr/bin/env python3
import serial
import threading
import sys

CMD_PORT = "/dev/ttyAMA0"   # commands out to STM32 USART1 (GPIO 14/15)
ECHO_PORT = "/dev/ttyACM0"  # debug echo back from STM32 USART2 (USB)
BAUD = 115200

# open both ports
cmd = serial.Serial(CMD_PORT, BAUD, timeout=1)
echo = serial.Serial(ECHO_PORT, BAUD, timeout=1)

def read_echo():
    while True:
        line = echo.readline()
        if line:
            sys.stdout.write("  << " + line.decode(errors="replace"))
            sys.stdout.flush()

# background thread prints whatever the STM32 echoes back
threading.Thread(target=read_echo, daemon=True).start()

print(f"Sending on {CMD_PORT}, listening on {ECHO_PORT}")
print("Type commands like f800, r500, s0. Ctrl-C to quit.")

try:
    while True:
        line = input("> ").strip()
        if not line:
            continue
        cmd.write((line + "\n").encode())
except KeyboardInterrupt:
    print("\nClosing.")
finally:
    cmd.close()
    echo.close()
