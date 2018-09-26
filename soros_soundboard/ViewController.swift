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
    var player: AVPlayer!
    // nem tudjuk inicializalni init idoben, viszont biztosan tudjuk kesobb e utana meg mar mindig letezni fog, tehat lehet "Implicitly Unwrapped Optional"-t hasznalni, mivel a nil eset itt szemantikailag mindig helytelen a futasido nagy reszeben, reszletesebben: "Implicitly Unwrapped Optionals" resz itten: https://docs.swift.org/swift-book/LanguageGuide/TheBasics.html
    let tracks = ["annyitiser",
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func notePressed(_ sender: UIButton) {
        
        // kerlek mindig ird ki h self.xyz, sokkal jobb ha mindig egyertelmu minek mi az eletciklusa (tudom h senki sem teszi.. de tenyleg jobb ugy)
        if self.player.play() == false { // ha meg nem megy semmi
           
            if  let buttonPressed = buttons.index(of: sender) {
                if let path = Bundle.main.path(forResource: tracks[buttonPressed], ofType : "mp3") {
                    let url = URL(fileURLWithPath : path)
                    do {
                        player = try AVAudioPlayer(contentsOf: url)
                        player.play()
                    } catch let error {
                        print ("There is an issue with this code! \(error.localizedDescription)")
                    }
                } else {
                    print("wrong path \(tracks[buttonPressed])")
                }
            }
        } else { //ha mar megy valami
            
        }
        
    }
    
}


