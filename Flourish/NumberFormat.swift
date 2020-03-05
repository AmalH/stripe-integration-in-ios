import Foundation

final class NumberFormat {
  

  
  private static let shared = NumberFormat()
  
  private lazy var formatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.maximumFractionDigits = 2
    formatter.numberStyle = .currency
    formatter.currencyCode = Constants.defaultCurrency
    return formatter
  }()
  
  private init() {
    // private
  }
  
  static func format(value: Int) -> String {
    let number = NSDecimalNumber(value: value)
    let numberDividedByOneHundred = number.dividing(by: NSDecimalNumber(value: 100))
    guard let formattedString = shared.formatter.string(from: numberDividedByOneHundred) else {
      fatalError("\(value) cannot be formatted correctly")
    }
    return formattedString
  }
  
}
