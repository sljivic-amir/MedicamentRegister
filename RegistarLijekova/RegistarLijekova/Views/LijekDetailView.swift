//
//  LijekDetailView.swift
//  RegistarLijekova
//
//  Created by Amir Sljivic on 19. 10. 2022..
//

import SwiftUI

struct LijekDetailView: View {
    var item: Registar
    var lijekId: Int
    
    @State var supstanceDetails : [Supstanca] = [Supstanca()]


    var body: some View {
        ScrollView{
            VStack{
                HStack{
                    Image("pill")
                        .resizable()
                        .scaledToFit()
                        .frame(width:100)
                        .shadow(radius: 10)
                    VStack(alignment: .leading){
                        Text("\(item.lijek?.name ?? "")")
                            .font(.title3)
                        HStack{
                            Text("\(item.lijek?.atc ?? "") - \(item.kategorija?.name ?? "")")
                                .font(.caption)
                            Spacer()
                        }
                        
                    }
                }.padding()
                Text("\(item.lijek?.shortDescription ?? "")")
                Divider()
                
                Boxes(item:item)
                
                Divider()
                Text("\(item.lijek?.description ?? "")").multilineTextAlignment(.leading)
                Spacer()
                
                    .task{
                            do {
                                supstanceDetails =  try await Supstanca().getSupstanceDetails(id:lijekId)
                            } catch {
                                    print("Error", error)
                            }
                    }
                Text("\(supstanceDetails[0].name)")
                    .font(.title3)
                    .bold()
            }
            
            
        }

    }

    
}


struct Boxes: View {
    var item: Registar
    var body: some View {
        HStack{
            VStack{
                Text("Aktivna supstanca").multilineTextAlignment(.center)
                ZStack{
                    Rectangle().fill(.blue).frame(height: 50)
                    .cornerRadius(9)
                    Text("\(item.lijek?.activeSupstanceValue ?? "/")")
                }
            }
            VStack{
                Text("Omjer aktivne supstance").multilineTextAlignment(.center)
                ZStack{
                    Rectangle().fill(.green).frame(height: 50)
                        .cornerRadius(9)
                    Text("\(item.lijek?.activeSubstanceSelectedQuantity ?? 0)")
                }
            }
            VStack{
                Text("Preporucena dnevna doza").multilineTextAlignment(.center)
                ZStack{
                    Rectangle().fill(.yellow).frame(height: 50)
                        .cornerRadius(9)
                    Text("\(item.lijek?.maximumDailyDose ?? 0)")
                }
            }
        }
        .padding()
    }
    
}

struct LijekDetailView_Previews: PreviewProvider {
    static var previews: some View {
        LijekDetailView(item: Registar(id:UUID(), lijek:Lijek(id:0), kategorija:Kategorija(id:0)), lijekId: 0)
    }
}

extension String {
    func load()-> UIImage{
        
        do{
            guard let url = URL(string: self)
            else{
                return UIImage()
            }
            let data: Data = try
            Data(contentsOf: url)
            
            return UIImage(data:data) ?? UIImage()
                        
        } catch {
            
        }
        
        return UIImage()
    }
}
