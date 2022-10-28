//
//  HomeView.swift
//  RegistarLijekova
//
//  Created by Amir Sljivic on 19. 10. 2022..
//

import SwiftUI

//enum categoryButtonColor : String { // might be useful
//    case A
//    case B
//    case C
//    case D
//    case V
//    case J
//    case S
//    case R
//    case P
//    case N
//    case M
//    case L
//    case H
//    case G
//}

func getButtonColor(color: String) -> Color? {
    switch color{
        case "A":
            return Color(hex: "#0056d6")
        case "B":
            return Color(hex:"#b51a00")
        case "C":
            return Color(hex:"#e32400")
        case "D":
            return Color(hex:"#ffc5ab")
        case "V":
            return Color(hex:"#fffbb9")
        case "J":
            return Color(hex: "#ffcb3e")
        case "S":
            return Color(hex:"#ff6a00")
        case "R":
            return Color(hex:"#00c7fd")
        case "P":
            return Color(hex: "#b1de8c")
        case "N":
            return Color(hex: "#1a0952")
        case "M":
            return Color(hex: "#f4a4c0")
        case "L":
            return Color(hex: "#61177c")
        case "H":
            return Color(hex: "#669d34")
        case "G":
            return Color(hex: "#004d65")
        default:
            return Color(hex: "#000000")
    }
}


struct HomeView: View {
    
    @State var searchText = ""
    @State var filtriraniRegistar : [Registar] = []
    @State var buttonPressed : Bool
    @State var medicamentDetails : [Lijek] = []
    @State var categoryDetails : [Kategorija] = []
    @State var registar = [Registar]()

    var body: some View {
        VStack {
            NavigationView {
                VStack{
                    VStack(alignment: .center){
                        ScrollView (.horizontal){
                            HStack(alignment:.center) {
                                ForEach(categoryFilter, id:\.self) { item in
                                    Button(action: {
                                        buttonPressed.toggle()
                                        print("Pritisnut button sa tipkom ", item)
                                        for registar in medicaments{
                                            if(registar.kategorija?.mark == item){
                                                var novi = medicaments
                                                novi = medicaments.filter{(registar) in registar.kategorija?.mark ==  item}
                                                filtriraniRegistar = novi
                                            }
                                        }
                                    }) {
                                        Text(item)
                                            .frame(width:20)
                                            .foregroundColor(.white)
                                            .font(.system(size: 18))
                                            .padding()
                                            .overlay(
                                                RoundedRectangle(cornerRadius: 1)
                                                    .stroke(Color.white, lineWidth: 2)
                                            )
                                    }

                                    .frame(width: 35)
                                    .background(buttonPressed ? getButtonColor(color: item) : Color(hex: "#b6cafc"))
                                    .cornerRadius(16)
                                }
                                List(filteredMedicament){ item in
                                    Text(item.kategorija?.mark ?? "")
                                }
                                
                            }
                        }
                        .frame(height: 50)
                    }
                    .offset(x:72)
                    Divider()
                    //here view in order to make white bg
                    List(!buttonPressed ? medicaments :  filtriraniRegistar) { item in
                        NavigationLink(destination:LijekDetailView(item:item, lijekId:item.lijek?.id ?? 0).navigationBarTitle("Detalji Lijeka", displayMode: .inline) , label:{
                            VStack(alignment: .leading) {
                                HStack{
                                    Rectangle()
                                        .fill(Color(hex: item.kategorija?.color ?? "#FFFFFF"))
                                        .frame(width: 8, height:30)
                                    VStack(alignment: .leading) {
                                        Text(item.lijek?.name ?? "")
                                            .font(.subheadline)
                                            .bold()
                                        HStack{
                                            Text("\(item.lijek?.atc ?? "")" + "-" + "\(item.kategorija?.name ?? "")" )
                                                .font(.system(size: 12))
                                        }
                                    }
                                }
                            }
                            
                        })
                    }
                       
                
                    .frame( maxWidth: .infinity)
                    .edgesIgnoringSafeArea(.all)
                    // .listStyle(GroupedListStyle())
                    .listStyle(.plain)
                    

                  //  .frame(maxWidth: , alignment: .leading)
                        
                    

                    .searchable(text:$searchText)
                    .navigationTitle("Registar lijekova")
                }
                                   
                                   
        }
            
            .task{
                    do {
                        medicamentDetails =  try await Lijek().getMedicament()
                        categoryDetails = try await Kategorija().getCategory()
                        print("dohvaceni lijekovi = ", medicamentDetails)
                        print("dohvacene kategorije = ", categoryDetails)
                        for lijek in medicamentDetails {
                            for kategorija in categoryDetails {
                                if(lijek.categoryId == kategorija.id){
                                    registar.append(Registar(id: UUID(), lijek: lijek, kategorija: kategorija))
                                }
                            }
                        }
                        print("dohvaceni registar = ", registar)

                    } catch {
                            print("Error", error)
                    }
            }
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
    var medicaments : [Registar]{
        
        return searchText == "" ? registar : registar.filter{(reg) -> Bool in (reg.lijek?.name)?.lowercased().contains(searchText.lowercased()) ?? false}
    }
    
    var categoryFilter : [String]{
        var stringovi  : [String] = []
        
        for item in medicaments{
            if(item.lijek?.categoryId == item.kategorija?.id){
                guard !stringovi.contains(item.kategorija?.mark ?? "") else { continue }
                stringovi.append(item.kategorija?.mark ?? "")
            }
        }
        return stringovi.sorted()
    }
    
}
struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(buttonPressed:false)
    }

}
extension Color {
    init(hex: String) {
        let hex = hex.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (1, 1, 1, 0)
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue:  Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
