//
//  traindetail.swift
//  MusicApp
//
//  Created by 林博堯 on 2020/1/7.
//  Copyright © 2020 SHIH-YING PAN. All rights reserved.
//

import SwiftUI
import CryptoKit
struct traindetail: View {
    @State private var Train = [trains]()
    var body: some View {
        VStack{
            ForEach(Train.filter({
                return ($0.OriginStopTime.hour==getnowhour())||($0.OriginStopTime.hour==getnowhour()+1)||($0.OriginStopTime.hour==getnowhour()+2)||($0.OriginStopTime.hour==getnowhour()+3)
            }).sorted{
                if $0.OriginStopTime.hour==$1.OriginStopTime.hour{
                    return $0.OriginStopTime.minute<$1.OriginStopTime.minute
                }
                else{
                    return $0.OriginStopTime.hour<$1.OriginStopTime.hour
                }
            }){
                (train) in trainRow(starttrain: train.OriginStopTime, endtrain: train.DestinationStopTime)
            }.onAppear{
                self.gettrain(date:self.date(),start:"0600",end:"2200")
            }
        }
    }
    
    func getnowhour() -> Int {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "HH"
        let time = Int(dateFormater.string(from: Date()))!
        return time
    }
    
    func date() -> String{
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "yyyy-MM-dd"
        let time=dateFormater.string(from: Date())
        return time
    }
    func getTimeString() -> String {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = "EEE, dd MMM yyyy HH:mm:ww zzz"
        dateFormater.locale = Locale(identifier: "en_US")
        dateFormater.timeZone = TimeZone(secondsFromGMT: 0)
        let time = dateFormater.string(from: Date())
        return time
    }
    func gettrain(date:String,start:String,end:String){
        let query="https://ptx.transportdata.tw/MOTC/v2/Rail/TRA/DailyTimetable/OD/"+start+"/to/"+end+"/"+date+"?$top=30&$format=JSON"
        if let urlStr = query.addingPercentEncoding(withAllowedCharacters:
            .urlQueryAllowed){
            
        if let url = URL(string: urlStr) {
            let APP_ID = "2ffd7b9cd4064405a473996d187d81f7"
            let APP_KEY = "sR0aj7HP1eqKBmiQ2XJBkr2takc"

            let xdate = getTimeString()
            let signDate = "x-date: \(xdate)"
            let key = SymmetricKey(data: Data(APP_KEY.utf8))
            let hmac = HMAC<SHA256>.authenticationCode(for: Data(signDate.utf8), using: key)
            let base64HmacString = Data(hmac).base64EncodedString()
            let authorization = """
            hmac username="\(APP_ID)", algorithm="hmac-sha256", headers="x-date", signature="\(base64HmacString)"
            """
            var request = URLRequest(url: url)
            request.setValue(xdate, forHTTPHeaderField: "x-date")
            request.setValue(authorization, forHTTPHeaderField: "Authorization")

            request.setValue("gzip", forHTTPHeaderField: "Accept-Encoding")
            URLSession.shared.dataTask(with: request) { (data, response , error) in
                let decoder = JSONDecoder()
                if let data = data, let trainResults = try? decoder.decode([trains].self, from: data) {
                    self.Train = trainResults
                }
                else{
                    print("error")
                }
            }.resume()
        }
    }
    }
}

struct traindetail_Previews: PreviewProvider {
    static var previews: some View {
        traindetail()
    }
}
