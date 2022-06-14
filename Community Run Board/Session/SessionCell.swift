//
//  SessionCell.swift
//  Community Run Board
//
//  Created by Anthony Mac on 2022-06-10.
//

import SwiftUI

struct SessionCellDayOfWeekCircle: View {
    
    @State var active: Bool
    @State var dayString: String
    @State var sizing: CGFloat = 14
    
    var body: some View {
        
        VStack {
            
            Image(systemName: active ? "calendar.circle.fill": "calendar.circle" )
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: sizing, height: sizing)
                .foregroundColor(active ? .green : .gray)
            
            Text(dayString)
                .font(.caption2)
        }
    }
}

struct SessionCellUserCircle: View {
    
    @State var booked: Bool
    
    var body: some View {
        
        VStack {
            
            Image(systemName: booked ? "person.crop.circle.fill.badge.checkmark": "person.circle" )
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 14, height: 14)
                .foregroundColor(booked ? .gray : .green)
                .font(.caption2)
            
        }
        
    }
}

struct SessionCellUserCircleList: View {
    
    @State var users: [userJoined]
    @State var groupSize: Int
    
    var body: some View {
     
        HStack {
            
            ForEach(0...groupSize, id: \.self){ index in
             
                if users.count <= index {
                    SessionCellUserCircle(booked: true)
                } else {
                    SessionCellUserCircle(booked: false)
                }
                
                
            }

        }


        
    }
}


struct SessionCellDayOfWeekCircleObject: Hashable {
    var active: Bool
    var dayString: String
}

struct userJoined: Hashable {
    var userName: String
}

struct cellTextLabel: View {
    
    var systemImage: String
    var text: String
    
    var body: some View {
    
        Image(systemName: systemImage)
            .renderingMode(.original)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 12, height: 12)
        Text(text)

    }
    
}


struct SessionCell: View {
    
    @State var location: String = "CN Tower"
    @State var distance: String = "5km"
    @State var pace: String = "Easy"
    @State var time: String = "6am"
    @State var totalSpots: Int = 5
    @State var spots: Int = 1
    @State var frequency: [String] = ["Monday", "Tuesday"]
    
    @State var fullSession: Bool
    @State var showDetail: Bool = false
    
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
            
            RoundedRectangle(cornerRadius: 5, style: .continuous)
                .fill(fullSession ? .green : .red)
                            .frame(height: 140)
                            .offset(x: -3, y: 5)

            RoundedRectangle(cornerRadius: 5, style: .continuous)
                            .fill(.white)
                            .frame(height: 140)
            
            VStack {
                
                HStack {
                    
                    cellTextLabel(systemImage: "map.fill", text: location)
                    cellTextLabel(systemImage: "fuelpump", text: distance)
                    cellTextLabel(systemImage: "flame", text: pace)
                    cellTextLabel(systemImage: "clock", text: time)

                }.padding(.top, 10)
                
                HStack {
                    
                    VStack {
                        SessionCellUserCircleList(users: users, groupSize: totalSpots)
                    
                    HStack {
                        ForEach(days, id: \.self) { day in
                            SessionCellDayOfWeekCircle(active: day.active, dayString: day.dayString)
                        }
                    }
                    }.padding()
                
                    VStack {
                  
                        Text("\(spots) SPOT LEFT")
                            .font(.headline)
                            .foregroundColor(.primary)
                            .padding()
                        Button {
                            showDetail.toggle()
                        } label: {
                            Text("See Details")
                        }.tint(.blue)
                        .buttonStyle(.bordered)
                        .controlSize(.small)
                        
                    }

                    
                    
                }
                
            }


        }
        .fullScreenCover(isPresented: $showDetail, content: {SessionDetail(fullSession: true)})
            .padding(.bottom, 3)
            .padding(.leading, 10)
            .padding(.trailing, 10)
    }
    
}

struct SessionCell_Previews: PreviewProvider {
    
    static var previews: some View {
        Group {
            ScrollView {
                SessionCell(fullSession: true)
                SessionCell(fullSession: false)
                SessionCell(fullSession: false)
                SessionCell(fullSession: true)
                SessionCell(fullSession: false)
                SessionCell(fullSession: true)
                SessionCell(fullSession: true)

            }
            ScrollView {
                SessionCell(fullSession: true)
                SessionCell(fullSession: false)
                SessionCell(fullSession: false)
                SessionCell(fullSession: true)
                SessionCell(fullSession: false)
                SessionCell(fullSession: true)
                SessionCell(fullSession: true)
                
            }
        }


    }
}
