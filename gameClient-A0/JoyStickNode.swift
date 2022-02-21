//
//  JoyStickNode.swift
//  gameClient-A0
//
//  Created by the Dragon on 04.02.2022.
//

import SpriteKit


class JoyStickNode: SKShapeNode {
	private let stick = SKShapeNode(circleOfRadius: 1)
	var externalRadius:CGFloat = .zero {
		didSet {
			path = SKShapeNode(circleOfRadius: externalRadius).path
			stick.path = SKShapeNode(circleOfRadius: externalRadius / 2.5).path
		}
	}
	var stickPosition: CGPoint = .zero {
		didSet {
			stick.position = stickPosition
		}
	}
	
	
	
	
	override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		guard let touch = touches.first else { return }
		processTouch(touch: touch)
	}
	override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
		guard let touch = touches.first else { return }
		processTouch(touch: touch)
	}
	override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
		stickPosition = .zero
	}
	override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
		stickPosition = .zero
	}
	
	
	private func processTouch(touch: UITouch) {
		let location = touch.location(in: self)
		let newStickPosition = location
		
		let lenQ:CGFloat = newStickPosition.x*newStickPosition.x + newStickPosition.y*newStickPosition.y
		let len = sqrt(lenQ)
		var coeff = len / (externalRadius * 1.2)
		
		if coeff < 1 {
			coeff = 1
		}
		stickPosition = CGPoint(x: newStickPosition.x/coeff, y: newStickPosition.y/coeff)
		
	}
	
	
	
	override init() {
		super.init()
		isUserInteractionEnabled = true
		stick.fillColor = UIColor.darkGray
		stick.strokeColor = UIColor.darkGray.withAlphaComponent(0.8)
		stick.lineWidth = 10
		addChild(stick)
	}
	
	required init?(coder aDecoder: NSCoder) {fatalError("init(coder:) has not been implemented")}
}
