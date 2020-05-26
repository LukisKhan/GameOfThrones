
import UIKit

//To make API calls to http endpoint (Unsecured) need to add to plist.
//Info.plist
//App Transport Security Settings -> Allow Arbitrary Loads -> YES

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    //Outlets and variables
    @IBOutlet weak var tableView: UITableView!
    @IBAction func pressedNext() {
        let youtubeView = storyboard?.instantiateViewController(withIdentifier: "youtube") as! YTViewController
        navigationController?.pushViewController(youtubeView, animated: true)
    }
    var episodes = [Episode]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
      
    }

    private func getData() {
        let url = URL(string: "https://api.tvmaze.com/shows/82?embed=seasons&embed=episodes")!
        URLSession.shared.dataTask(with: url) {(data, response, error) in
            
            do {
                let gameOfThrones = try JSONDecoder().decode(GameOfThronesIMDB.self, from: data!)
                self.episodes = gameOfThrones.episodeObject.episodes
                DispatchQueue.main.asyncAfter(deadline: .now() + 0, execute: {
                    self.tableView.reloadData()
                })
            }
                
            catch {
                print("There was an error with downloading the data")
            }
        }.resume()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return episodes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "episodeCell", for: indexPath) as! EpisodeCell
        cell.title.text = self.episodes[indexPath.row].name
        if let imageURL = URL(string: self.episodes[indexPath.row].image.medium) {
            DispatchQueue.global().async {
               let data = try? Data(contentsOf: imageURL)
               if let data = data {
                   let myImage = UIImage(data: data)
                   DispatchQueue.main.async {
                        cell.episodeImage.image = myImage
                   }
               }
           }
        }
        cell.episodeImage.image = UIImage(named: "Stark")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let epiVC = storyboard?.instantiateViewController(identifier: "episode") as? EpisodeViewController else { return }
         print("selected \(episodes[indexPath.row].name)")
        epiVC.episode = episodes[indexPath.row]
        epiVC.myImageURL = episodes[indexPath.row].image.original
        navigationController?.pushViewController(epiVC, animated: true)
        
    }

}


//Struc for JSON Parsing
struct GameOfThronesIMDB: Codable {
    let episodeObject: Episodes
    
    private enum CodingKeys: String, CodingKey {
        case episodeObject = "_embedded"
    }
}

struct Episodes: Codable {
    let episodes: [Episode]
}

//name, season, number,  airdate, airtime, runtime, summary
struct Episode: Codable {
    let id: Int
    let name: String
    let season: Int
    let epi: Int
    let summary: String
    let airdate: String
    let airtime: String
    let runtime: Int
    let image: Image
    
    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case season
        case summary
        case airdate
        case airtime
        case runtime
        case image
        case epi = "number"
    }
    //    let airdate: Date
    //    let airtime: DateComponents
    //    let runtime: DateComponents
}

struct Image: Codable {
    let medium: String
    let original: String
}


