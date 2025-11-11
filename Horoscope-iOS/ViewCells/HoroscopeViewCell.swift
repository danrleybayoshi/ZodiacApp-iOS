//
//  HoroscopeViewCell.swift
//  Horoscope-iOS
//
//  Created by Mananas on 6/11/25.
//

import UIKit

class HoroscopeViewCell: UITableViewCell {

    @IBOutlet weak var signImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var datesLabel: UILabel!
    
    @IBOutlet weak var favoriteImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func render(_ horoscope: Horoscope) {
        nameLabel.text = horoscope.name
        datesLabel.text = horoscope.dates
        signImageView.image = horoscope.getSignIcon()
        favoriteImageView.isHidden = !SessionManager().isFavorite(sign: horoscope.id)
    }

}
