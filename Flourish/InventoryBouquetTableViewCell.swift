import UIKit
import AlamofireImage

class InventoryBouquetTableViewCell: UITableViewCell {
  
  override func prepareForReuse() {
    super.prepareForReuse()
    photoImageView.af_cancelImageRequest()
  }
  
  @IBOutlet var photoImageView: UIImageView!
  @IBOutlet var nameLabel: UILabel!
  @IBOutlet var detailLabel: UILabel!
  
  func configure(with bouquet: Bouquet) {
    nameLabel.text = bouquet.name
    detailLabel.text = bouquet.types
    photoImageView.af_setImage(withURL: bouquet.photoUrl)
  }
}
