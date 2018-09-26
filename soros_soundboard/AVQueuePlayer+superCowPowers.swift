//
//  AVQueuePlayer+superCowPowers.swift
//  soros_soundboard
//
//  Created by Oliver Kocsis on 26/09/2018.
//  Copyright © 2018 Laszlo Kocsis. All rights reserved.
//

import Foundation
import AVFoundation
import ObjectiveC

// Declare a global var to produce a unique address as the assoc object handle
private var AssociatedObjectHandle: UInt8 = 0

extension AVQueuePlayer {
private typealias DidReachEndHandler = (() -> Void)
    
    private var _playerItemDidReachEnd: DidReachEndHandler? {
        get {
            return objc_getAssociatedObject(self, &AssociatedObjectHandle) as? DidReachEndHandler
        }
        set {
            objc_setAssociatedObject(self, &AssociatedObjectHandle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    
    func loadAndPlayItem(item: AVPlayerItem, completion: (() -> Void)? = nil) {
        
        self._playerItemDidReachEnd?()
        
        self._playerItemDidReachEnd = completion
        self.removeAllItems()
        self.insert(item, after: nil)
        self.play()
        
        NotificationCenter
            .default
            .addObserver(self,
                         selector: #selector(AVQueuePlayer.playerItemDidReachEnd(notification:)),
                         name: .AVPlayerItemDidPlayToEndTime,
                         object: self.currentItem)
    }
    
    @objc func playerItemDidReachEnd(notification notif: NSNotification) {
        self._playerItemDidReachEnd?()
    }
}
