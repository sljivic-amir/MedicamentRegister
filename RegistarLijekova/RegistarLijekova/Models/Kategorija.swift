//
//  File.swift
//  RegistarLijekova
//
//  Created by Amir Sljivic on 19. 10. 2022..
//

import Foundation

class Kategorija :Identifiable, Decodable {
    var id = 0
    var mark : String? = ""
    var name : String? = ""
    var color : String? = ""
    
    init(id: Int = 0, mark: String = "", name: String = "", color: String = "") {
        self.id = id
        self.mark = mark
        self.name = name
        self.color = color
    }
    
    func getCategory()  async throws -> [Kategorija] {
        guard let url = URL(string: "https://api.farmaceut.ba/test/categories") else { fatalError("Missing URL") }
            let urlRequest = URLRequest(url: url)
            let (data, response) = try await URLSession.shared.data(for: urlRequest)

            guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
            let decodedCategory = try JSONDecoder().decode([Kategorija].self, from: data)
            
            print("Async kategorija", decodedCategory[0].name)

            return decodedCategory
    }
}
