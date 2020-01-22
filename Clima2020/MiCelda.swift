//
//  MiCelda.swift
//  Clima2020
//
//  Created by IPaco on 22/01/2020.
//  Copyright © 2020 IPaco. All rights reserved.
//

import UIKit

class MiCelda: UITableViewCell {
    @IBOutlet weak var ivIcoCalda: UIImageView!
    @IBOutlet weak var lblPronoCelda: UILabel!
    @IBOutlet weak var lblMinCelda: UILabel!
    @IBOutlet weak var lblMaxCelda: UILabel!
    @IBOutlet weak var lblPreCelda: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
