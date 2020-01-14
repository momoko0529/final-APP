//
//  data.swift
//  MusicApp
//
//  Created by 林博堯 on 2020/1/7.
//  Copyright © 2020 SHIH-YING PAN. All rights reserved.
//

import Foundation

struct trainti: Codable {
    var DepartureTime:String
    var StationName:StationName
    var hour:Int{
        get{
            return Int(DepartureTime.components(separatedBy: ":")[0])!
        }
    }
    var minute:Int{
        get{
            return Int(DepartureTime.components(separatedBy: ":")[1])!
        }

    }
}

struct trains: Codable ,Identifiable{
    let id=UUID()
    var TrainDate:String
    var OriginStopTime:trainti
    var DestinationStopTime:trainti
}
struct StationName: Codable {
    var Zh_tw:String
}
