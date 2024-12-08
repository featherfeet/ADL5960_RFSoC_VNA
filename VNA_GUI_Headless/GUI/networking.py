import io
import socket
import threading
import numpy as np
import queue

class RemoteConnection:
    def __init__(self, host, port):
        self.host = host
        self.port = port
        self.data = {}
        self.queue = queue.Queue()
        self.thread_handle = threading.Thread(target = self.socket_thread, args = ())
        self.thread_handle.start()

    def send_parameters(self, parameters):
        self.queue.put(parameters)

    def socket_thread(self):
        packet_length = None
        buffer = io.BytesIO()

        self.s = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        self.s.bind((self.host, self.port))
        self.s.listen()

        while True:
            print("Awaiting connection...")
            conn, addr = self.s.accept()
            print(f"Accepted connection from {addr}.")

            while True:
                # Send any enqueued messages to the FPGA.
                if not queue.empty():
                    message = queue.get()
                    message_pickled = pickle.dumps(message)
                    conn.sendall(len(message_pickled).to_bytes(4, "little"))
                    conn.sendall(message_pickled)
                # Receive incoming messages from the FPGA.
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
                        buffer.seek(0)
                        data_unpickled = pickle.load(buffer)
                        data_tmp = {}
                        data_tmp["filtered_port1_forward"] = np.frombuffer(data_unpickled["filtered_port1_forward"], dtype = np.float64)
                        data_tmp["filtered_port2_forward"] = np.frombuffer(data_unpickled["filtered_port2_forward"], dtype = np.float64)
                        data_tmp["filtered_port1_reverse"] = np.frombuffer(data_unpickled["filtered_port1_reverse"], dtype = np.float64)
                        data_tmp["filtered_port2_reverse"] = np.frombuffer(data_unpickled["filtered_port2_reverse"], dtype = np.float64)
                        self.data = data_tmp

                        buffer = io.BytesIO()
                        packet_length = None

            print(f"Connection from {addr} closed.")
            packet_length = None
            buffer = io.BytesIO()
