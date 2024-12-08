import pickle
from websockets.sync.client import connect

class GuiRemoteConnection:
    def __init__(self):
        self.websocket = connect("ws://192.168.0.105:1234")

    def send_message(self, message):
        bytes_to_send = pickle.dumps(message)
        self.websocket.send(bytes_to_send)
    
    def receive_message(self):
        try:
            message_pickled = self.websocket.recv(timeout = 0.01)
            return pickle.loads(message_pickled)
        except TimeoutError:
            return None
