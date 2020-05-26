
import UIKit

class EpisodeViewController: UIViewController {

    @IBOutlet var episodeTitle: UILabel!
    @IBOutlet var summary: UILabel!
    @IBOutlet var runtime: UILabel!
    
    @IBOutlet weak var season: UILabel!
    @IBOutlet weak var epi: UILabel!
    @IBOutlet weak var airdate: UILabel!
    @IBOutlet weak var airtime: UILabel!
    @IBOutlet weak var mononoke: UIImageView!
    
    var myImageURL: String = ""
    
    public var episode: Episode?
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        view.backgroundColor = .systemGray6
        let yourImage = UIImage(named: "Fire")
        view.backgroundColor = UIColor(patternImage: yourImage!)
        episodeTitle.text = "Title: " + episode!.name
        let summaryText = episode!.summary.replacingOccurrences(of: "<p>", with: "")
        let summaryTextTwo = summaryText.replacingOccurrences(of: "</p>", with: "")
        summary.text = "Summary: " + summaryTextTwo
        season.text = "Season: " + String(episode!.season)
        episode!.epi < 10 ? (epi.text = "Episode: 0" + String(episode!.epi)) : (epi.text = "Episode: " + String(episode!.epi))
        runtime.text = "Runtime: " + String(episode!.runtime)
        airdate.text = "Air Date: " + String(episode!.airdate)
        airtime.text = "Air Time: " + String(episode!.airtime)
        
        mononoke.loadImage(imageURL: URL(string: myImageURL)!)
    }
    


}


extension UIImageView {
    func loadImage(imageURL: URL) {
        DispatchQueue.global().async {
           let data = try? Data(contentsOf: imageURL)
           if let data = data {
               let myImage = UIImage(data: data)
               DispatchQueue.main.async {
                    self.image = myImage
               }
           }
       }
    }
}
