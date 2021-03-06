//
//  HomeView.swift
//  TravelApp
//
//  Created by Dzmitry Semenovich on 1.06.21.
//

import SwiftUI

class RequestSettings: ObservableObject {
    @Published var city = ""
    @Published var checkIn = Date()
    @Published var checkOut = Date()
    @Published var adults = 1
    @Published var maxPrice = 300
    @Published var minPrice = 150
    @Published var isEmpty = false
}

struct HomeView: View {
    
    @AppStorage("language")
    private var language = LocalizationService.shared.language
    @StateObject var settings = RequestSettings()
    @State private var showingSheet = false
    @State private var isPresented = false
    
    var body: some View {
        
        VStack {
            
            ZStack(alignment: .trailing) {
                RoundedRectangle(cornerRadius: 30)
                    .frame(height: 55)
                    .foregroundColor(Color(.secondarySystemBackground))
                    .padding()
                
                TextField("Find your travel direction".localized(language), text: $settings.city)
                    .padding(.leading)
                    .offset(x: 12)
                
                Button(action: {
                    
                    if settings.city != "" && (settings.maxPrice > settings.minPrice) && (settings.checkIn <= settings.checkOut){
                        
                        self.showingSheet.toggle()
                    } else {
                        settings.isEmpty.toggle()
                    }
                }) {
                    Circle()
                        .frame(width: 45, height: 45)
                        .foregroundColor(Color("mainColor"))
                        .overlay(Image(systemName: "magnifyingglass")
                                    .foregroundColor(.white))
                        .padding(.trailing)
                        .offset(x: -5)
                }.alert(isPresented: $settings.isEmpty, content: {
                    Alert(title: Text("Failed".localized(language)), message: Text("Input data is incorrect".localized(language)), dismissButton: .default(Text("Ok")))
                }).fullScreenCover(isPresented: $showingSheet, content: {
                    LoadView(hotels: HotelRequest(city: settings.city, checkIn: settings.checkIn, checkOut: settings.checkOut, adults: settings.adults, maxPrice: settings.maxPrice, minPrice: settings.minPrice))
                })
            }
            
            
            Form{
                
                Section(header: Text("Date".localized(language)).fontWeight(.heavy).font(.title3)){
                    
                    VStack{
                        
                        DatePicker("Check in date".localized(language), selection: $settings.checkIn, displayedComponents: [.date])
                    }
                    VStack{
                        
                        DatePicker("Check out date".localized(language), selection: $settings.checkOut, displayedComponents: [.date])
                    }
                    
                }
                Section(header: Text("People".localized(language)).fontWeight(.heavy).font(.title3)) {
                    
                    
                    Stepper("Amount of adults  \(settings.adults)".localized(language), value: $settings.adults, in: 1...6)
                    
                }
                
                Section(header: Text("Price".localized(language)).fontWeight(.heavy).font(.title3)) {
                    
                    Stepper("Maximum price  \(settings.maxPrice)".localized(language), value: $settings.maxPrice, in: 300...1000, step: 20)
                    
                    Stepper("Minimum price  \(settings.minPrice)".localized(language), value: $settings.minPrice, in: 50...700, step: 20)
                    
                }
            }
            
        }.environmentObject(settings)
    }
}



struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}
