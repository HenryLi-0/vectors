extends Node3D

@onready var left: Camera3D = $GridContainer/LeftSubViewportContainer/LeftSubViewport/left
@onready var right: Camera3D = $GridContainer/RightSubViewportContainer/RightSubViewport/right
#var server:TCPServer = TCPServer.new()
#var peer:WebSocketPeer
#var connected:bool = false
#var PORT:int = 1155
# ref: https://docs.godotengine.org/en/stable/tutorials/networking/websocket.html

func _ready() -> void:
	'''camera stuff'''
	left.position = position
	left.rotation = rotation
	#right.position = position
	#right.rotation = rotation
	
	## above blue reef
	#right.position = Vector3(-4.45, 4.5, 0.0)
	#right.rotation = Vector3(-PI/2,-PI/2,0)
	right.position = Vector3(-5.3, 3.1, 0)
	right.rotation = Vector3(-PI/2,-PI/2,0)
	
	#'''server stuff'''
	#if server.listen(PORT) == OK:
		#print("SERVER CONNECTED TO PORT ", server.get_local_port())
		#print(IP.get_local_addresses())
	#else:
		#print("SERVER DID NOT CONNECT")
		#push_warning("SERVER DID NOT CONNECT")

func _process(delta: float) -> void:
	#if not(connected) and server.is_connection_available():
		#var stream = server.take_connection()
		#stream.set_no_delay(true)
		#peer = WebSocketPeer.new()
		#if peer.accept_stream(stream) == OK:
			#connected = true
			#print("SERVER HAS CONNECTED CLIENT VIA WEBSOCKET")
		#else:
			#peer = null
			#push_warning("SERVER FAILED CONNECTION")
	#if connected and peer != null:
		#peer.poll()
		#var state = peer.get_ready_state()
		#if state == WebSocketPeer.STATE_OPEN:
			#while peer.get_available_packet_count() > 0:
				#var packet = peer.get_packet()
				#if peer.was_string_packet():
					#print("message: ", packet.get_string_from_utf8())
		#elif state == WebSocketPeer.STATE_CLOSING:
			#pass
		#elif state == WebSocketPeer.STATE_CLOSED:
			#print("SERVER CLIENT DISCONNECTED")
			#connected = false
			#peer = null
	pass
