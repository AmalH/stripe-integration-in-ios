import UIKit
import Stripe

class CheckoutViewController: UIViewController {

  private enum Section: Int {
    case bouquets = 0
    case total
    
    static func cellIdentifier(for section: Section) -> String {
      switch section {
      case .bouquets:
        return "CheckoutBouquetTableViewCell"
      case .total:
        return "CheckoutTotalTableViewCell"
      }
    }
  }

  @IBOutlet var tableView: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    title = "Checkout"
  }
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    
    tableView.reloadData()
  }
  
  @IBAction func continueDidTap(_ sender: Any) {
    // 1
    guard CheckoutCart.shared.canPay else {
      let alertController = UIAlertController(title: "Warning", message: "Your cart is empty", preferredStyle: .alert)
      let alertAction = UIAlertAction(title: "OK", style: .default)
      alertController.addAction(alertAction)
      present(alertController, animated: true)
      return
    }
    // 2
    let addCardViewController = STPAddCardViewController()
    addCardViewController.delegate = self
    navigationController?.pushViewController(addCardViewController, animated: true)
  }
}

extension CheckoutViewController: STPAddCardViewControllerDelegate {
  
  func addCardViewControllerDidCancel(_ addCardViewController: STPAddCardViewController) {
    navigationController?.popViewController(animated: true)
  }
  
  func addCardViewController(_ addCardViewController: STPAddCardViewController, didCreateToken token: STPToken, completion: @escaping STPErrorBlock) {
    StripeClient.shared.completeCharge(with: token, amount: CheckoutCart.shared.total) { result in
      switch result {
      // 1
      case .success:
        completion(nil)
        
        let alertController = UIAlertController(title: "Congrats", message: "Your payment was successful!", preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: { _ in
          self.navigationController?.popViewController(animated: true)
        })
        alertController.addAction(alertAction)
        self.present(alertController, animated: true)
      // 2
      case .failure(let error):
        completion(error)
      }
    }
  }
}

// MARK: - UITableViewDataSource
extension CheckoutViewController: UITableViewDataSource {

  func numberOfSections(in tableView: UITableView) -> Int {
    return 2
  }

  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    if section == Section.bouquets.rawValue {
      return CheckoutCart.shared.cart.count
    } else {
      return 1
    }
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let section = Section(rawValue: indexPath.section) else {
      fatalError("Section not found")
    }
    let identifier = Section.cellIdentifier(for: section)
    let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
    switch cell {
    case let cell as CheckoutBouquetTableViewCell:
      let bouquet = CheckoutCart.shared.cart[indexPath.row]
      cell.configure(with: bouquet)
    case let cell as CheckoutTotalTableViewCell:
      let total = CheckoutCart.shared.total
      cell.configure(with: total)
    default:
      fatalError("Cell does not match the correct type")
    }
    return cell
  }
  
  func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
    if indexPath.section == Section.bouquets.rawValue {
      return true
    } else {
      return false
    }
  }
  
  func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
    guard editingStyle == .delete else {
      return
    }
    let bouquet = CheckoutCart.shared.cart[indexPath.row]
    let isRemoved = CheckoutCart.shared.removeBouquet(bouquet)
    if isRemoved {
      tableView.beginUpdates()
      tableView.deleteRows(at: [indexPath], with: .automatic)
      tableView.reloadSections(IndexSet(integer: 1), with: .automatic)
      tableView.endUpdates()
    }
  }
}
