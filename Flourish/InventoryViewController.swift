import UIKit

class InventoryViewController: UIViewController {
  
  private enum CellIdentifiers {
    static let InventoryBouquetTableViewCell = "InventoryBouquetTableViewCell"
  }
  
  private enum StoryboardNames {
    static let Main = "Main"
  }
  
  private enum ViewControllerIdentifiers {
    static let Detail = "DetailViewController"
  }
  
  @IBOutlet var tableView: UITableView!
  
  private var bouquets: [Bouquet] = []
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Inventory"
    
    bouquets = DataProvider.shared.allBouquets
  }
}

// MARK: - UITableViewDataSource
extension InventoryViewController: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return bouquets.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.InventoryBouquetTableViewCell, for: indexPath) as! InventoryBouquetTableViewCell
    cell.configure(with: bouquets[indexPath.row])
    return cell
  }
  
}

// MARK: - UITableViewDelegate
extension InventoryViewController: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let storyboard = UIStoryboard(name: StoryboardNames.Main, bundle: nil)
    guard let detailViewController = storyboard.instantiateViewController(withIdentifier: ViewControllerIdentifiers.Detail) as? DetailViewController else {
      return
    }
    detailViewController.bouquet = bouquets[indexPath.row]
    navigationController?.pushViewController(detailViewController, animated: true)
  }
  
}
