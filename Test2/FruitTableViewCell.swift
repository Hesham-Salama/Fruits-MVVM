//
//  FruitTableViewCell.swift
//  Test2
//
//  Created by Hesham on 09/09/2022.
//

import UIKit

class FruitTableViewCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var priceLabel: UILabel!
    @IBOutlet var weightLabel: UILabel!
    @IBOutlet var fruitImageView: UIImageView!
    
    var onReuse: () -> Void = {}
    
    override func prepareForReuse() {
        fruitImageView.image = UIImage(systemName: "photo")
        fruitImageView.cancelImageLoad()
    }
}
