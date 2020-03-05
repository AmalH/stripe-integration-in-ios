import Foundation

final class CheckoutCart {

  static let shared = CheckoutCart()
  
  private init() {
    // private
  }

  private var bouquets: [Bouquet] = []

  var cart: [Bouquet] {
    return bouquets
  }
  
  var canPay: Bool {
    return !bouquets.isEmpty
  }

  var total: Int {
    return bouquets.reduce(0) { (result, bouquet) -> Int in
      return result + bouquet.price
    }
  }

  func addBouquet(_ bouquet: Bouquet) {
    guard !bouquets.contains(bouquet) else {
      return
    }
    bouquets.append(bouquet)
  }
  
  func removeBouquet(_ bouquet: Bouquet) -> Bool {
    guard let index = bouquets.index(of: bouquet) else {
      return false
    }
    bouquets.remove(at: index)
    return true
  }

}
