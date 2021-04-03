//
//  DishesCell.swift
//  Sushi & Wine
//
//  Created by Anton Levin on 03.04.2021.
//

import UIKit

class DishesCell: UITableViewCell {

 
  @IBOutlet weak var dishImage: UIImageView!
  @IBOutlet weak var dishName: UILabel!
  @IBOutlet weak var dishDescription: UILabel!
  @IBOutlet weak var dishPrice: UILabel!
  @IBOutlet weak var dishWeight: UILabel!
  
  override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
