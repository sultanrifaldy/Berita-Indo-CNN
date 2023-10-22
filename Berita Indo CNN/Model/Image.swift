//
//  Image.swift
//  Berita Indo CNN
//
//  Created by Sultan Rifaldy on 22/10/23.
//

import Foundation

struct Image: Decodable {
    let small: String
    let large: String
    
    enum CodingKeys: String, CodingKey {
        case small
        case large
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.small = try container.decodeIfPresent(String.self, forKey: .small) ?? ""
        self.large = try container.decodeIfPresent(String.self, forKey: .large) ?? ""
    }
}
