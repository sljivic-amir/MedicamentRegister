//
//  CategoryListView.swift
//  RegistarLijekova
//
//  Created by Amir Sljivic on 25. 10. 2022..
//

import SwiftUI

struct CategoryListView: View {
    var props : [String]
    var medicaments : [Registar]
    var registar : [Registar]
    // @ObservedObject var fetch = FetchRegister()

    var body: some View {
        VStack(alignment: .center){
            ScrollView (.horizontal){
                HStack(alignment:.center) {
                    ForEach(props, id:\.self) { item in
                        Button(action: {
                            print("Pritisnut button sa tipkom ", item)
                            for registar in medicaments{
                                if(registar.kategorija?.mark == item){
                                    print("uslov ispunjen")
                                    print("name == ", registar.lijek?.name ?? "")
                                    print("mark == ", registar.kategorija?.mark ?? "")
                                }
                            }
                            }) {
                            Text(item)
                                .frame(width:20)
                                .foregroundColor(.white)
                                .font(.system(size: 18))
                                .padding()
                                .overlay(
                                    RoundedRectangle(cornerRadius: 12)
                                        .stroke(Color.white, lineWidth: 2)
                                        .frame(width: 55, height: 55)
                                        .foregroundColor(Color(hex: "#b6cafc"))
                                    
                                )
                        }
                        .background(Color(hex: "#b6cafc"))
                        .cornerRadius(12)
                    }
                    List(filteredMedicament){ item in
                        Text(item.kategorija?.mark ?? "")
                    }
                    
                }
                
            }
            .frame(height: 50)

        }
      

    }
     
   
    var filteredMedicament : [Registar] {
        var filteredRegistar : [Registar] = []
        
        for reg in registar{
            print("registar = ", reg.lijek?.name ?? "")
            filteredRegistar.append(reg)
        }
        return filteredRegistar
    }
  
}


struct CategoryListView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryListView(props:categoryFilter, medicaments: medicaments, registar: [Registar()])
    }
}

var categoryFilter : [String]{

    return ["A","B","C","D"]
    
 
}
var medicaments : [Registar]{

    return [Registar(id:UUID(),lijek: Lijek(), kategorija: Kategorija())]
    
 
}
