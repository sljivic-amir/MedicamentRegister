//
//  Supstanca.swift
//  RegistarLijekova
//
//  Created by Amir Sljivic on 27. 10. 2022..
//

import Foundation

class Supstanca : Identifiable, Decodable{
       
    var id = 0
    var name = ""

    
    init(id: Int = 0, name: String = "") {
        self.id = id
        self.name = name
    }
    
    func getSupstanceDetails(id:Int)  async throws -> [Supstanca] {
        guard let url = URL(string: "https://api.farmaceut.ba/test/substances?drugid=\(id)") else { fatalError("Missing URL") }
            let urlRequest = URLRequest(url: url)
            let (data, response) = try await URLSession.shared.data(for: urlRequest)

            guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
            let decodedSupstance = try JSONDecoder().decode([Supstanca].self, from: data)
            
            print("Async supstanca", decodedSupstance[0].name)

            return decodedSupstance
    }

    
    
}
