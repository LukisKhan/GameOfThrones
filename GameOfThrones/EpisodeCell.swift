//
//  EpisodeCell.swift
//  GameOfThrones
//
//  Created by Rave BizzDev on 5/23/20.
//  Copyright © 2020 Rave BizzDev. All rights reserved.
//

import UIKit

class EpisodeCell: UITableViewCell {
    
    static let identifier = "episodeCell"
    
    //name (title), season, number (epi),  airdate, airtime, runtime, summary

    @IBOutlet weak var episodeImage: UIImageView!
    @IBOutlet weak var title: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = .systemGray6
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
