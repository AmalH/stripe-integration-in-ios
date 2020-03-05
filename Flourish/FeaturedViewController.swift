import UIKit

class FeaturedViewController: UIViewController {

  private enum SegueIdentifiers {
    static let Embed = "Embed"
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Featured Bouquet"
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    if let detailViewController = segue.destination as? DetailViewController, 
      segue.identifier == SegueIdentifiers.Embed {
      detailViewController.bouquet = DataProvider.shared.featuredBouquet
    }
  }

}
