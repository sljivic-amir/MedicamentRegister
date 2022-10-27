//
//  Lijek.swift
//  RegistarLijekova
//
//  Created by Amir Sljivic on 19. 10. 2022..
//

import Foundation

class Lijek : Identifiable, Decodable{
       
    var id = 0
    var name = ""
    var atc = ""
    var shortDescription : String?
    var description : String?
    var categoryId = 0
    var activeSupstanceValue : String?
    var activeSubstanceMeasurementUnit: String?
    var activeSubstanceSelectedQuantity : Int?
    var activeSubstanceQuantityMeasurementUnit : String?
    var minimumDailyDose : Int?
    var maximumDailyDose : Int?
    var showOnCalculator = false
    var forbiddenInPregnancy = false
    
    init(id: Int = 0, name: String = "", atc: String = "", shortDescription: String = "", description: String = "", categoryId: Int = 0, activeSupstanceValue: String = "" , activeSubstanceMeasurementUnit: String = "", activeSubstanceSelectedQuantity: Int = 0, activeSubstanceQuantityMeasurementUnit: String = "", minimumDailyDose: Int = 0, maximumDailyDose: Int = 0, showOnCalculator: Bool = false, forbiddenInPregnancy: Bool = false) {
        self.id = id
        self.name = name
        self.atc = atc
        self.shortDescription = shortDescription
        self.description = description
        self.categoryId = categoryId
        self.activeSupstanceValue = activeSupstanceValue
        self.activeSubstanceMeasurementUnit = activeSubstanceMeasurementUnit
        self.activeSubstanceSelectedQuantity = activeSubstanceSelectedQuantity
        self.activeSubstanceQuantityMeasurementUnit = activeSubstanceQuantityMeasurementUnit
        self.minimumDailyDose = minimumDailyDose
        self.maximumDailyDose = maximumDailyDose
        self.showOnCalculator = showOnCalculator
        self.forbiddenInPregnancy = forbiddenInPregnancy
    }
    
    func getMedicament()  async throws -> [Lijek] {
        guard let url = URL(string: "https://api.farmaceut.ba/test/medicaments") else { fatalError("Missing URL") }
            let urlRequest = URLRequest(url: url)
            let (data, response) = try await URLSession.shared.data(for: urlRequest)

            guard (response as? HTTPURLResponse)?.statusCode == 200 else { fatalError("Error while fetching data") }
            let decodedMedicament = try JSONDecoder().decode([Lijek].self, from: data)
            
            print("Async lijek", decodedMedicament[0].name)

            return decodedMedicament
    }
    
    
}

//
//let listaLijekova = [
//    Lijek(id: 218,name: "Tensec1",atc: "C07AB07",shortDescription: "null",description: "null",categoryId: 1, activeSupstanceValue: 0, activeSubstanceMeasurementUnit: "null", activeSubstanceSelectedQuantity: 0, activeSubstanceQuantityMeasurementUnit: "null",minimumDailyDose: 0, maximumDailyDose: 0,showOnCalculator: false,forbiddenInPregnancy: false),
//    Lijek(id: 219,name: "Tensec2",atc: "C07AB07",shortDescription: "null",description: "null",categoryId: 1, activeSupstanceValue: 0, activeSubstanceMeasurementUnit: "null", activeSubstanceSelectedQuantity: 0, activeSubstanceQuantityMeasurementUnit: "null",minimumDailyDose: 0, maximumDailyDose: 0,showOnCalculator: false,forbiddenInPregnancy: false),
//    Lijek(id: 220,name: "Tensec3",atc: "C07AB07",shortDescription: "null",description: "null",categoryId: 1, activeSupstanceValue: 0, activeSubstanceMeasurementUnit: "null", activeSubstanceSelectedQuantity: 0, activeSubstanceQuantityMeasurementUnit: "null",minimumDailyDose: 0, maximumDailyDose: 0,showOnCalculator: false,forbiddenInPregnancy: false)]

//let listaLijekova = LijekUtils().getMedicaments()
