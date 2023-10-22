//
//  NewsResponse.swift
//  Berita Indo CNN
//
//  Created by Sultan Rifaldy on 22/10/23.
//

import Foundation

struct NewsResponse: Decodable {
    let messages: String
    let total: Int
    let data: [News]
    
    enum CodingKeys: String, CodingKey {
        case messages
        case total
        case data
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.messages = try container.decodeIfPresent(String.self, forKey: .messages) ?? ""
        self.total = try container.decodeIfPresent(Int.self, forKey: .total) ?? 0
        self.data = try container.decodeIfPresent([News].self, forKey: .data) ?? []
    }
}
