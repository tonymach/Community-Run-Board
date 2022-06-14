//
//  SessionDetail.swift
//  Community Run Board
//
//  Created by Anthony Mac on 2022-06-11.
//

import SwiftUI

struct SessionDetail: View {
    
    
    @State var location: String = "CN Tower"
    @State var distance: String = "5km"
    @State var pace: String = "Easy"
    @State var time: String = "6am"
    @State var totalSpots: Int = 5
    @State var spots: Int = 1
    @State var frequency: [String] = ["Monday", "Tuesday"]
    
    @State var fullSession: Bool
    
    @StateObject var locationManager: LocationManager = .init()

    var days: [SessionCellDayOfWeekCircleObject]  = [
        SessionCellDayOfWeekCircleObject(active: true, dayString: "M"),
        SessionCellDayOfWeekCircleObject(active: false, dayString: "Tu"),
        SessionCellDayOfWeekCircleObject(active: false, dayString: "W"),
        SessionCellDayOfWeekCircleObject(active: true, dayString: "Th"),
        SessionCellDayOfWeekCircleObject(active: false, dayString: "F"),
        SessionCellDayOfWeekCircleObject(active: true, dayString: "Sa"),
        SessionCellDayOfWeekCircleObject(active: false, dayString: "Su")
    ]
    
    var users: [userJoined] = [userJoined(userName: "tim"),
                               userJoined(userName: "tom"),
                               userJoined(userName: "bob")
    ]
    
    
    var body: some View {
        
        ZStack {
            
            
            VStack {
                
                MapViewSelection()
                    .environmentObject(locationManager)
                    .navigationBarHidden(true)
                
                Spacer()

                HStack {
   
                    Text(distance)
                        .font(.title)
                        .bold()
                    Text("\(pace) pace")
                        .font(.title)
                
                }
                Text("This is an address that goes to Google Maps.")
                Divider()
                Text("Starts at \(time) and will take 45min")
                
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {

                        ForEach(days, id: \.self) { day in
                            SessionCellDayOfWeekCircle(active: day.active, dayString: day.dayString, sizing: 50)
                        }
                    }
                }
                Text("Monday, June the 20th")
                    .font(.largeTitle)
                ScrollView(.horizontal) {
                    HStack(spacing: 20) {
                        ForEach(0..<5) {index in
                            sessionDetailUserCircle(booked: false, name: "First L.")
                        
                        }
                    }
                }


                
             

            }

            dismissButton()
            
        }
            .padding(.bottom, 3)
            .padding(.leading, 10)
            .padding(.trailing, 10)
        
    }
}

struct SessionDetail_Previews: PreviewProvider {
    static var previews: some View {
        SessionDetail(fullSession: true)
    }
}


struct sessionDetailUserCircle: View {
    
    @State var booked: Bool
    @State var isLead: Bool = false
    @State var name: String
    
    var body: some View {
        
        VStack {
            
            
            if !booked {
                
                Image(systemName: "person.crop.circle.fill.badge.checkmark") //This will be an actual image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50)
                    .font(.caption2)
                
                Label(name, systemImage: "star.square")
                

                
            } else {
                
                Image(systemName: booked ? "person.crop.circle.fill.badge.checkmark": "person.crop.circle.badge.plus" ) //This is an actual image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 50)
                    .foregroundColor(booked ? .gray : .green)
                    .font(.caption2)
                
                Text(name)
            }
            
           
            
        }
        
    }
}



struct dismissButton: View {
    
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        
        VStack(alignment: .trailing) {
          
            HStack {
                Spacer()
            Button {dismiss()} label : {
                Image(systemName: "xmark")
                        .renderingMode(.original)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 15)
                        .padding()
                
            }.frame(width: 80, height: 80, alignment: .trailing)
            }
            Spacer()

        }
    }
}
