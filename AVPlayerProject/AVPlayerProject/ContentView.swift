//
//  ContentView.swift
//  AVPlayerProject
//
//  Created by lorenzo Decaria on 10/17/22.
//

import SwiftUI

struct ContentView: View {    
    
    let playerManager: PlayerManageable
    
    var body: some View {
        Text("COMCAST streaming assignment")
        .onAppear {
            playerManager.initialize()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(playerManager: PlayerManager())
    }
}
