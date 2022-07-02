import Foundation

struct CollectionProductModel: Decodable {
    let left: CollectionProductData
    let right: CollectionProductData
}

struct CollectionProductData: Decodable {
    let iconName: String
    let title: String
    let detail: String
}
