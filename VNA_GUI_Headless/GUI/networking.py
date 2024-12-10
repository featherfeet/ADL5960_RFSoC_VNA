import io
import pickle
import threading
import numpy as np
from websockets.sync.server import serve

class RemoteConnection:
    def __init__(self, host, port):
        self.host = host
        self.port = port
        self.server = serve(self.handle_message, host, port)
        self.websocket_server_thread_handle = threading.Thread(target = self.websocket_server_thread, args = ())
        self.websocket_server_thread_handle.start()
        self.client_connections = []
        self.data = {}

    def websocket_server_thread(self):
        self.server.serve_forever()

    def send_parameters(self, parameters):
        message_pickled = pickle.dumps(parameters)
        for client in self.client_connections:
            print("Sending")
            client.send(message_pickled)

    def handle_message(self, websocket):
        self.client_connections.append(websocket)

        for message in websocket:
            data_unpickled = pickle.loads(message)
            data_tmp = {}
            data_tmp["filtered_port1_forward"] = np.frombuffer(data_unpickled["filtered_port1_forward"], dtype = np.float64)
            data_tmp["filtered_port2_forward"] = np.frombuffer(data_unpickled["filtered_port2_forward"], dtype = np.float64)
            data_tmp["filtered_port1_reverse"] = np.frombuffer(data_unpickled["filtered_port1_reverse"], dtype = np.float64)
            data_tmp["filtered_port2_reverse"] = np.frombuffer(data_unpickled["filtered_port2_reverse"], dtype = np.float64)
            data_tmp["raw_s_parameters"] = data_unpickled["raw_s_parameters"]
            self.data = data_tmp
