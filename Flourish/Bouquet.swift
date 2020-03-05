import Foundation

struct Bouquet: Codable {
  let id: Int
  let name: String
  let price: Int
  let photoUrl: URL
  let types: String
  
  enum CodingKeys: String, CodingKey {
    case id = "id"
    case name = "name"
    case types = "types"
    case photoUrl = "photo_large"
    case price = "price"
}
}

extension Bouquet: Equatable {
  static func ==(bqt: Bouquet, boqt: Bouquet) -> Bool {
    return bqt.id == boqt.id
  }
}
