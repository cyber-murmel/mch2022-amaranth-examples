# UART Echo
This example implements an UART loopback on the FPGA and sets the red and green LEDs to the
to LSBs of the received character.

You can connect to to the FPGA UART through the second ACM TTY (`/dev/ttyACM1`).

```shell
# configure FPGA
python3 uart.py
# connect to it
python3 -m serial.tools.miniterm --exit-char 24 --raw /dev/ttyACM1 115200
```