//
//  NetWorking.swift
//  gameClient-A0
//
//  Created by the Dragon on 04.02.2022.
//

import Foundation
import Network
import CoreGraphics



var udp = MyUDP()


final class MyUDP: ObservableObject {
	private var connection: NWConnection = NWConnection(host: "192.168.2.141", port: 61616, using: .udp)
	
	@Published var state: NWConnection.State
	@Published var messages: [String] = []
	@Published var playerName = "test Player"
	var tagID: String {
		playerName
	}
	
	init() {
		self.state = .cancelled
		print("MyUDP init ..")
		setupStateHandler()
		doStart()
	}
	deinit {
		print(".. DEINIT MyUDP")
	}
	
	func resetConnection() {
		setupStateHandler()
		doStart()
	}
	
	private func setupStateHandler() {
		connection.stateUpdateHandler = { (newState) in
			DispatchQueue.main.async {
				weak var thisOne = self
				thisOne?.state = newState
			}
		}
	}
	private func doStart() {
		connection.start(queue: .global())
		setupReceiver()
	}
	
	func pushDataToSender(data: Data?) {
		sendData(data, on: connection){endpoint,error in
			if let error = error {
				print("\n\ncontentProcessed with error:")
				print(error)
			}
		}
	}
	
	private func setupReceiver() {
		receiveData(on: connection){endpoint,data,error in
			guard let data = data else {return}
			resultDBG = MainCoder.decode(String.self, from: data)
			print(".. message: \(String(describing: resultDBG))")
			self.setupReceiver()
		}
	}
	
	
	func requestDBG() {
		applyRequest( .debugIformation, data: nil)
	}
	func requestJoy(status: JoyStatus) {
		let data = MainCoder.encode(status)
		applyRequest( .joystickPosition, data: data)
	}

	private func applyRequest( _ request: RequestType, data: Data?) {
		let requestA0 = RequestA0(tagID: tagID, request: request, data: data)
		pushDataToSender(data: MainCoder.encode(requestA0))
	}
	
}



