//
//  FavouriteTableViewCell.swift
//  moviesplanner
//
//  Created by Charbel El Hajj on 20/01/2021.
//

import UIKit

class FavouriteTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBOutlet weak var wallpaper: UIImageView!
    @IBOutlet weak var title: UILabel!
    
}

