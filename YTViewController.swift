
import UIKit
import youtube_ios_player_helper

class YTViewController: UIViewController, YTPlayerViewDelegate {

    @IBOutlet var playerView: YTPlayerView!
    @IBAction func podPressed() {
        playerView.load(withVideoId: "ZCnEJYds1iA",
                        playerVars: ["playsinline": 1, "start" : 26])
    }
    @IBAction func florencePressed() {
        playerView.load(withVideoId: "eTa1jHk1Lxc",
                        playerVars: ["playsinline": 1, "start" : 9])
    }
    @IBAction func lotrPressed() {
        playerView.load(withVideoId: "VM9wWtHozCM",
                        playerVars: ["playsinline": 1, "start" : 82])
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        playerView.delegate = self
        playerView.load(withVideoId: "ZCnEJYds1iA",
                        playerVars: ["playsinline": 1, "start" : 26])
        
    }
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        playerView.playVideo()
    }
}
