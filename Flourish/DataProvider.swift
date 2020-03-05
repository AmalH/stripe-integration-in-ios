import Foundation

final class DataProvider {
  
  static let shared = DataProvider()
  
  private init() {
  }

  var allBouquets: [Bouquet] {
    guard let jsonData = read(from: "bouquets") else {
      fatalError("The app cannot work without bouquets")
    }
    print(jsonData);
    let decoder = JSONDecoder()
    guard let decoded = try? decoder.decode([Bouquet].self, from: jsonData) else {
      fatalError("Invalid JSON data")
    }
    return decoded
  }

  var featuredBouquet: Bouquet {
    //let randomIndex = Int(arc4random_uniform(UInt32(allBouquets.count)))
    return allBouquets[4]
  }
  
  private func read(from path: String) -> Data? {
    guard let path = Bundle.main.path(forResource: path, ofType: "json") else {
      return nil
    }
    return try? Data(contentsOf: URL(fileURLWithPath: path))
  }
}
