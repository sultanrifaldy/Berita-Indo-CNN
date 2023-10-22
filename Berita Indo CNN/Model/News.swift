//
//  News.swift
//  Berita Indo CNN
//
//  Created by Sultan Rifaldy on 22/10/23.
//

import Foundation


struct News: Decodable {
    let title: String
    let link: String
    let contentSnippet: String
    let isoDate: String
    let image: Image
    
    enum CodingKeys: String, CodingKey {
        case title
        case link
        case contentSnippet
        case isoDate
        case image
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.title = try container.decodeIfPresent(String.self, forKey: .title) ?? ""
        self.link = try container.decodeIfPresent(String.self, forKey: .link) ?? ""
        self.contentSnippet = try container.decodeIfPresent(String.self, forKey: .contentSnippet) ?? ""
        self.isoDate = try container.decodeIfPresent(String.self, forKey: .isoDate) ?? ""
        self.image = try container.decode(Image.self, forKey: .image)
    }
}
