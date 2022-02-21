//
//  ButtonSetNode.swift
//  gameClient-A0
//
//  Created by the Dragon on 04.02.2022.
//

import SpriteKit


class ButtonSetNode: SKShapeNode {
	private let button = SKShapeNode(circleOfRadius: 1)
	var externalRadius:CGFloat = .zero {
		didSet {
			path = SKShapeNode(circleOfRadius: externalRadius).path
			button.path = SKShapeNode(circleOfRadius: externalRadius / 1.35).path
		}
	}
	var isPressed: Bool = false {
		didSet {
			button.setScale(isPressed ? 1.2 : 1)
		}
	}
	
	
	
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		guard let _ = touches.first else { return }
		isPressed = true
	}
	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		isPressed = false
	}
	override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
		isPressed = false
	}
	
	
	
	
	
	override init() {
		super.init()
		isUserInteractionEnabled = true
		strokeColor = UIColor.clear
		button.fillColor = UIColor.darkGray.withAlphaComponent(0.9)
		button.strokeColor = UIColor.darkGray
		button.lineWidth = 5
		addChild(button)
	}
	
	required init?(coder aDecoder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
