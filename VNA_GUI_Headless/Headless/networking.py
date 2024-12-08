import socket
import pickle

class GuiRemoteConnection:
    def __init__(self):
        self.gui_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
        self.gui_socket.connect(("192.168.0.105", 1234))

    def send_message(self, message):
        bytes_to_send = pickle.dumps(message)
        self.gui_socket.sendall(len(bytes_to_send).to_bytes(4, "little"))
        self.gui_socket.sendall(bytes_to_send)
