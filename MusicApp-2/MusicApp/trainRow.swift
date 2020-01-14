//
//  trainRow.swift
//  MusicApp
//
//  Created by 林博堯 on 2020/1/7.
//  Copyright © 2020 SHIH-YING PAN. All rights reserved.
//

import SwiftUI

struct trainRow: View {
    var starttrain:trainti
    var endtrain:trainti
    var body: some View {
        HStack{
            Text(starttrain.StationName.Zh_tw)
            Text("\(starttrain.hour):")
            Text("\(starttrain.minute)       ")
            Text("\(endtrain.hour):")
            Text("\(endtrain.minute)")
            Text(endtrain.StationName.Zh_tw)
        }
    }
}

struct trainRow_Previews: PreviewProvider {
    static var previews: some View {
        trainRow(starttrain:  trainti(DepartureTime:"12:00",StationName:StationName(Zh_tw:"基隆")),endtrain:trainti(DepartureTime:"21:00",StationName:StationName(Zh_tw:"板橋")))
    }
}
