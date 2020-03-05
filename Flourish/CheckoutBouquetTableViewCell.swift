import Foundation
import UIKit

class CheckoutBouquetTableViewCell: UITableViewCell {
  
  @IBOutlet var nameLabel: UILabel!
  @IBOutlet var priceLabel: UILabel!
  
  func configure(with bouquet: Bouquet) {
    nameLabel.text = bouquet.name
    priceLabel.text = NumberFormat.format(value: bouquet.price)
  }
}
