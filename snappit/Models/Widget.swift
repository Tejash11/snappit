import Foundation

struct AppWidget: Identifiable, Codable {
    let id: Int
    let type: String
    let heading: String
    let aspectRatio: Double
    let items: [WidgetItem]
    let isStatic: Bool
    let autoScroll: Bool
    let displayVertical: Bool
    let categoryRow: Int
    let categoryColumn: Int

    enum CodingKeys: String, CodingKey {
        case id
        case type
        case heading
        case aspectRatio = "aspect_ratio"
        case items
        case isStatic = "is_static"
        case autoScroll = "auto_scroll"
        case displayVertical = "display_vertical"
        case categoryRow = "category_row"
        case categoryColumn = "category_column"
    }
}

struct WidgetItem: Identifiable, Codable {
    let id: Int?
    let type: String?
    let isClickable: Bool?
    let products: [Product]?
    let imageUrl: String?
    let slaveKey: String?

    enum CodingKeys: String, CodingKey {
        case id
        case type
        case isClickable = "is_clickable"
        case products
        case imageUrl = "image_url"
        case slaveKey = "slave_key"
    }
}

struct Category: Identifiable, Codable, Hashable {
    let id: Int
    let name: String
    let imageUrl: String

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case imageUrl = "image_url"
    }
}
