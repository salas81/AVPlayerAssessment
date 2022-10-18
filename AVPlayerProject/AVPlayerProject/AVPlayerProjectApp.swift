//
//  AVPlayerProjectApp.swift
//  AVPlayerProject
//
//  Created by lorenzo Decaria on 10/17/22.
//

import SwiftUI

@main
struct AVPlayerProjectApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView(playerManager: PlayerManager())
        }
    }
}
