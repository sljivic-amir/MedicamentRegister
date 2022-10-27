//
//  Registar.swift
//  RegistarLijekova
//
//  Created by Amir Sljivic on 19. 10. 2022..
//

import Foundation

class Registar :Identifiable {
    var id :UUID
    var lijek: Lijek?
    var kategorija: Kategorija?
    
    init(id: UUID = UUID(), lijek: Lijek? = nil, kategorija: Kategorija? = nil) {
        self.id = id
        self.lijek = lijek
        self.kategorija = kategorija
    }

}
