//
//  gameClient_A0App.swift
//  gameClient-A0
//
//  Created by the Dragon on 04.02.2022.
//

import SwiftUI

@main
struct gameClient_A0App: App {
	var body: some Scene {
		WindowGroup {
			ContentView()
		}
	}
}


func raaLog(_ str: String) {
	print(str)
	DispatchQueue.main.async {
		//globalInfo.logs += "\n\(str)"
	}
}

extension NSObject {
	var raaClassName: String {
		String(describing: type(of: self))
	}
}
