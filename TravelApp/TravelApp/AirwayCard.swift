//
//  AirwayCard.swift
//  TravelApp
//
//  Created by Dzmitry Semenovich on 5.06.21.
//

import SwiftUI

struct AirwayCard: View {
    
    @State var company : String
    @State var price : Int
    
    var body: some View {
        
        HStack {
            
            VStack(alignment: .leading) {
                
                Text(" \(company)").font(.title2).fontWeight(.regular).lineLimit(1).frame(maxWidth: .infinity, alignment: .leading).padding(.bottom, 1)
                
                Text("Price : $\(price)").font(.body).fontWeight(.light)
                
            }
            Image(systemName: "airplane").font(.title).foregroundColor(Color.blue).imageScale(.large).frame(width: 70, height: 70,alignment: .leading)
            
        }.padding(10)
    }
}

struct AirwayCard_Previews: PreviewProvider {
    static var previews: some View {
        AirwayCard(company: "LOT", price: 70).previewLayout(.sizeThatFits)
    }
}
