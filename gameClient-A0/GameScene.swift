//
//  GameScene.swift
//  gameClient-A0
//
//  Created by the Dragon on 04.02.2022.
//

import SpriteKit

var resultDBG: String?

let udpTimeCounterMAX: Double = 0.02

class GameScene: SKScene, ObservableObject {
	let battleNode = SKShapeNode(rectOf: CGSize(width: 1, height: 1))
	let leftJoystick = JoyStickNode()
	let rightJoystick = ButtonSetNode()
	var externalSize:CGSize = .zero {
		didSet {
			size = externalSize
		}
	}
	
	@Published var dbgText = ""
	private var udpTimeCounter: Double = 0
	private var lastTimeUpdate: Double = 0
	
	override func update(_ currentTime: TimeInterval) {
		let timeDelay = currentTime - lastTimeUpdate
		lastTimeUpdate = currentTime
		//
		if udpTimeCounter > udpTimeCounterMAX {
			udpTimeCounter = 0
			let status = JoyStatus(timeStamp: currentTime, leftStickPosition: leftJoystick.stickPosition, rightButton: rightJoystick.isPressed)
			udp.requestJoy(status: status)
		}else{
			udpTimeCounter += timeDelay
		}
		//
		dbgText = resultDBG ?? ""
	}
	
	
	
	override func didChangeSize(_ oldSize: CGSize) {
		//raaLog(raaClassName + " resize to \(size) from \(oldSize)")
		let len = size.width > size.height ? size.height : size.width
		let tmpBattle = SKShapeNode(rectOf: CGSize(width: len, height: len))
		battleNode.path = tmpBattle.path
		let joyAreaRadius = len / 3.5
		leftJoystick.externalRadius = joyAreaRadius
		leftJoystick.position.x = joyAreaRadius - size.width / 2
		leftJoystick.position.y = joyAreaRadius - size.height / 2
		rightJoystick.externalRadius = joyAreaRadius
		rightJoystick.position.x = -joyAreaRadius + size.width / 2
		rightJoystick.position.y = joyAreaRadius - size.height / 2
	}
	
	override func didMove(to view: SKView) {
		view.isMultipleTouchEnabled = true
	}

	override init() {
		super.init(size: .zero)
		raaLog( raaClassName + " init ..")
		anchorPoint.x = 0.5
		anchorPoint.y = 0.5
		addChild(battleNode)
		addChild(leftJoystick)
		addChild(rightJoystick)
	}
	
	required init?(coder aDecoder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
