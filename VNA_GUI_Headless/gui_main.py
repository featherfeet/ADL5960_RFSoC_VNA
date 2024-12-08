#!/usr/bin/env python3

import asyncio
import fastplotlib as fpl
import numpy as np
import io
import zlib
import threading
import socket

"""
def handle_message(ws, message, opcode):
    print(f"Got message, {len(message)} bytes")
    message_obj = io.BytesIO(message)
    data = np.load(message_obj)
    print(data.keys())

    def handle(self):
"""

data = {}

def socket_thread():
    global data

    packet_length = None
    buffer = io.BytesIO()

    s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
    s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
    s.bind(("0.0.0.0", 1234))
    s.listen()

    while True:
        conn, addr = s.accept()
        print(f"Accepted connection from {addr}.")

        while True:
            if packet_length == None:
                received = conn.recv(4)
                if len(received) == 0:
                    break
                packet_length = int.from_bytes(received, byteorder = "little")
            else:
                received = conn.recv(4096)
                if len(received) == 0:
                    break
                buffer.write(received)
                if buffer.getbuffer().nbytes == packet_length:
                    decompressed = io.BytesIO()
                    decompressed.write(zlib.decompress(buffer.getvalue()))
                    decompressed.seek(0)
                    data = np.load(decompressed)
                    buffer = io.BytesIO()
                    packet_length = None

        print(f"Connection from {addr} closed.")
        packet_length = None
        buffer = io.BytesIO()

figure = fpl.Figure(size=(700, 560))

# plot the image data
empty = np.zeros(400024)
port1_forward = figure[0, 0].add_line(empty, name="Port 1 Forward", colors="r")
port2_forward = figure[0, 0].add_line(empty, name="Port 2 Forward", colors="g")
port1_reverse = figure[0, 0].add_line(empty, name="Port 1 Reverse", colors="b")
port2_reverse = figure[0, 0].add_line(empty, name="Port 2 Reverse", colors="w")

# increment along the x-axis on each render loop :D
def update_line(subplot):
    if len(data.keys()):
        subplot["Port 1 Forward"].data[:, 1] = data["filtered_port1_forward"].real
        subplot["Port 2 Forward"].data[:, 1] = data["filtered_port2_forward"].real
        subplot["Port 1 Forward"].data[:, 1] = data["filtered_port1_reverse"].real
        subplot["Port 2 Forward"].data[:, 1] = data["filtered_port2_reverse"].real

figure[0, 0].add_animations(update_line)

figure.show(maintain_aspect=False)

socket_thread_handle = threading.Thread(target = socket_thread, args = ())
socket_thread_handle.start()

fpl.run()
