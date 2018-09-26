//
//  ViewController.swift
//  soros_soundboard
//
//  Created by Laszlo Kocsis on 2018. 09. 12..
//  Copyright © 2018. Laszlo Kocsis. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    @IBOutlet var buttons: [UIButton]!
    var queuePlayer: AVQueuePlayer!
    // nem tudjuk inicializalni init idoben, viszont biztosan tudjuk kesobb e utana meg mar mindig letezni fog, tehat lehet "Implicitly Unwrapped Optional"-t hasznalni, mivel a nil eset itt szemantikailag mindig helytelen a futasido nagy reszeben, reszletesebben: "Implicitly Unwrapped Optionals" resz itten: https://docs.swift.org/swift-book/LanguageGuide/TheBasics.html
    let tracks =
        ["annyitiser",
         "balogorban",
         "befogadni",
         "bekopogtattak",
         "benak",
         "bloff",
         "bortfogokinni",
         "buli",
         "cianosindito",
         "cocacola",
         "csicska",
         "csokoljameg",
         "dugunkegyet",
         "egyenesbeszedu",
         "elofordul",
         "elotteisgazdagvoltam",
         "eloveszekegykalasnyikovot",
         "elutasitja",
         "ensz",
         "ezarovarbekattant",
         "ezatokeletes",
         "ezfelhaborito",
         "eztabalfaszt",
         "ezveszelyes",
         "fatigertek",
         "gyuri",
         "hanemnyerunk",
         "ihatok",
         "istenkuldte",
         "jezus",
         "jobbanteljesit",
         "jotevetszeretnek",
         "kaptunktizezer",
         "karacsony",
         "kigyokkigyoztak",
         "kiralyunk",
         "kormany",
         "kormanydolga",
         "kveszcson",
         "letezik",
         "maganszfera",
         "matolcsyadvent",
         "matolcsynemeztkerdeztuk",
         "mcdonald",
         "megtanuljak",
         "migransmentes",
         "nehagyjuk",
         "nemnezikibelolem",
         "nemvagyokatlag",
         "nobody",
         "nomajgrenc",
         "pacekba",
         "pliz",
         "rezsicsokkentes",
         "rofi",
         "rovidbeszed",
         "sonkakeszul",
         "sorosbrusszel",
         "stopsoros",
         "szelid",
         "szemoldokcsipesz",
         "szoknya",
         "thankyou",
         "urigyerek",
         "verem",
         "vizionalt"]
    
    lazy var playerItems =
        self.tracks.map { (trackName) -> AVPlayerItem? in
            guard
                let url = Bundle.main.url(forResource: trackName,
                                          withExtension: "mp3")
            else {
                return nil
            }
            return AVPlayerItem(url: url)
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.queuePlayer = AVQueuePlayer()
    }
    
    
    @IBAction func notePressed(_ sender: UIButton) {
        
        guard
            let buttonIndex = buttons.index(of: sender),
            let item = self.playerItems[buttonIndex]
        else {
            return
        }
        
        if self.queuePlayer.timeControlStatus != .paused {
            self.queuePlayer.reset()
        }

        sender.isSelected = true
        
        //check out a completion closure-t a vegen, ami akkor fut le amikor egy playback veget er
        self.queuePlayer.loadAndPlayItem(item: item, completion: {
            sender.isSelected = false
        })
        
        
        
    }
    
}


