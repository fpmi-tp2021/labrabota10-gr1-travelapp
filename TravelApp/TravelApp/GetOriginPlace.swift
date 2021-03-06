//
//  GetOriginPlace.swift
//  TravelApp
//
//  Created by Dzmitry Semenovich on 5.06.21.
//

import SwiftUI

class AirwaysRequestSettings : ObservableObject {
    
    @Published var cityFrom = ""
    @Published var isPresented = false
}

struct GetOriginPlace: View {
    @AppStorage("language")
    private var language = LocalizationService.shared.language
    @StateObject var airwaysRequest = AirwaysRequestSettings()
    
    @State var cityTo = ""
    @State var name = ""
    @State var price = ""
    @State var date = ""
    
    var body: some View {
        VStack {
            
            Spacer()
            
            Image("page2").resizable().aspectRatio(contentMode: .fit).scaledToFit()
            
            Text("Let's find the best prices for plane!".localized(language)).fontWeight(.semibold)
                .kerning(1.3)
                .multilineTextAlignment(.center).padding()
            
            
            Spacer()
            
            ZStack(alignment: .trailing) {
                RoundedRectangle(cornerRadius: 30)
                    .frame(height: 55)
                    .foregroundColor(Color(.secondarySystemBackground))
                    .padding()
                
                TextField("Enter the origin place".localized(language), text: $airwaysRequest.cityFrom)
                    .padding(.leading)
                    .offset(x: 12)
                
                Button(action: {
                    airwaysRequest.isPresented.toggle()
                }) {
                    Circle()
                        .frame(width: 45, height: 45)
                        .foregroundColor(Color("mainColor"))
                        .overlay(Image(systemName: "magnifyingglass")
                                    .foregroundColor(.white))
                        .padding(.trailing)
                        .offset(x: -5)
                }.fullScreenCover(isPresented: $airwaysRequest.isPresented, content: {
                    AirwaysLoadView(airways: AirwaysRequest(cityFrom: self.airwaysRequest.cityFrom, cityTo: self.cityTo, date: self.date), name: self.name, price: self.price )
                })
            }
        }
    }
}

struct GetOriginPlace_Previews: PreviewProvider {
    static var previews: some View {
        GetOriginPlace()
    }
}
