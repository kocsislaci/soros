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

typealias DidReachEndHandler = (() -> Void)

// Declare a global var to produce a unique address as the assoc object handle
private var AssociatedObjectHandle: UInt8 = 0

extension AVPlayerItem {
    fileprivate var _playerItemDidReachEndOrFailed: DidReachEndHandler? {
        get {
            return objc_getAssociatedObject(self, &AssociatedObjectHandle) as? DidReachEndHandler
        }
        set {
            objc_setAssociatedObject(self, &AssociatedObjectHandle, newValue, objc_AssociationPolicy.OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

extension AVQueuePlayer {
    
    func reset() {
        self.items().forEach { (oldItem) in
            oldItem._playerItemDidReachEndOrFailed?()
            oldItem._playerItemDidReachEndOrFailed = nil
        }
        self.removeAllItems()
    }
    
    func loadAndPlayItem(item: AVPlayerItem, completion: DidReachEndHandler? = nil) {
        
        item.seek(to: CMTime.zero) { (succ) in
            guard
                succ
            else {
                item._playerItemDidReachEndOrFailed?()
                item._playerItemDidReachEndOrFailed = nil
                return
            }
            if self.items().contains(item) == false {
                self.insert(item, after: nil)
            }
            item._playerItemDidReachEndOrFailed = completion
            self.play()
        }
        
        let center = NotificationCenter.default
        center.addObserver(self,
                           selector: #selector(AVQueuePlayer.playerItemDidReachEndOrFailed(notification:)),
                           name: .AVPlayerItemDidPlayToEndTime,
                           object: self.currentItem)
        center.addObserver(self,
                           selector: #selector(AVQueuePlayer.playerItemDidReachEndOrFailed(notification:)),
                           name: .AVPlayerItemFailedToPlayToEndTime,
                           object: self.currentItem)
    }
    
    @objc func playerItemDidReachEndOrFailed(notification notif: NSNotification) {
        guard
            let playerItem = notif.object as? AVPlayerItem
        else {
            return
        }
        playerItem._playerItemDidReachEndOrFailed?()
        playerItem._playerItemDidReachEndOrFailed = nil
    }
}
