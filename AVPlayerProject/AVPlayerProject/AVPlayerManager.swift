//
//  AVPlayerManager.swift
//  AVPlayerProject
//
//  Created by lorenzo Decaria on 10/17/22.
//

import Foundation
import Combine
import AVFoundation

protocol PlayerManageable {
    func initialize()
}

class PlayerManager: NSObject {
    static let streamURL = "https://devstreaming-cdn.apple.com/videos/streaming/examples/bipbop_4x3/bipbop_4x3_variant.m3u8"
    
    private var cancellables = Set<AnyCancellable>()
    private var player: AVPlayer?

    func setupStartLog() {
        player?.addObserver(self, forKeyPath: "status", options: [.old, .new], context: nil)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "status" {
            if player?.rate ?? 0 > 0 {
                print("Playback started")
            }
        }
    }
    
    func setupStopLog() {
        NotificationCenter.default.publisher(for: .AVPlayerItemDidPlayToEndTime)
        .sink { _ in
            print("Playback reached end")
        }
        .store(in: &cancellables)
    }
    
    func setupPeriodicLog() {
        player?.addPeriodicTimeObserver(forInterval: CMTime(seconds: 0.5, preferredTimescale: CMTimeScale(NSEC_PER_SEC)), queue: DispatchQueue.global(), using: { [weak self] time in
            guard let _ = self else {
                return
            }
            
            print("Playhead time: \(CMTimeGetSeconds(time))")
        })
    }
}

extension PlayerManager: PlayerManageable {
    func initialize() {
        guard let url = URL(string: PlayerManager.streamURL) else {
            return
        }
        
        let playerItem = AVPlayerItem(url: url)
        player = AVPlayer(playerItem: playerItem)
        
        setupStartLog()
        setupStopLog()
        setupPeriodicLog()
        
        player?.play()
    }
}

