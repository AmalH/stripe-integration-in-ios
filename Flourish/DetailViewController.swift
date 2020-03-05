import UIKit
import AlamofireImage

class DetailViewController: UIViewController {
  
  @IBOutlet var imageView: UIImageView!
  @IBOutlet var nameLabel: UILabel!
  @IBOutlet var priceLabel: UILabel!
  @IBOutlet var imageActivityIndicator: UIActivityIndicatorView!
  @IBOutlet var typesLabel: UILabel!
    
  var bouquet: Bouquet!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    imageActivityIndicator.startAnimating()
    nameLabel.text = bouquet.name
    typesLabel.text = bouquet.types
    priceLabel.text = NumberFormat.format(value: bouquet.price)
    imageView.af_setImage(withURL: bouquet.photoUrl) { [weak self] _ in
      guard let strongSelf = self else {
        return
      }
      strongSelf.imageActivityIndicator.stopAnimating()
    }
  }
  
  @IBAction func addToCartDidTap(_ sender: Any) {
    CheckoutCart.shared.addBouquet(bouquet)
  }
}
