import Foundation

struct HomeModel: Decodable {
    let h1: String
    let patrimony: PatrimonyModel
    let h3: String
    let products: [CollectionProductModel]
}
