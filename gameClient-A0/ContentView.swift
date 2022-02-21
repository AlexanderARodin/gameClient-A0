//
//  ContentView.swift
//  gameClient-A0
//
//  Created by the Dragon on 04.02.2022.
//

import SwiftUI
import SpriteKit


struct ContentView: View {
	@StateObject var gameScene = GameScene()
	@ObservedObject var udpLink = udp
	
	var body: some View {
		GeometryReader {geometry in
			ZStack {
				getSpriteView(geometry: geometry)
				VStack {
					TextEditor(text: $gameScene.dbgText)
						.font(.footnote)
						.frame(width: geometry.size.width / 3.5, height: geometry.size.height / 1.7)
					Button("get dbg") {
						udp.requestDBG()
					}
					.padding()
					Spacer()
					TextField("player name", text: $udpLink.playerName)
						.padding()
						.font(.largeTitle)
						.frame(width: geometry.size.width / 3.5)
						.border(.red)
						.padding()
				}
			}
		}
		
	}
	func getSpriteView( geometry: GeometryProxy) -> SpriteView {
		gameScene.externalSize = geometry.size
		return SpriteView( scene: gameScene )
	}
}

struct ContentView_Previews: PreviewProvider {
	static var previews: some View {
		ContentView()
	}
}
