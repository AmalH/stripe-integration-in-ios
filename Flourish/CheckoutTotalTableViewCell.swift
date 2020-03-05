import Foundation
import UIKit

class CheckoutTotalTableViewCell: UITableViewCell {

  @IBOutlet var totalLabel: UILabel!

  func configure(with total: Int) {
    totalLabel.text = NumberFormat.format(value: total)
  }
  
}
