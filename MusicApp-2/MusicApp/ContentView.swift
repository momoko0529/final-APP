//
//  ContentView.swift
//  MusicApp
//
//  Created by SHIH-YING PAN on 2019/11/27.
//  Copyright © 2019 SHIH-YING PAN. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    @State private var songs = [Song]()

    func fetchSongs() {
          var urlComponents = URLComponents()
          urlComponents.host="itunes.apple.com"
          urlComponents.scheme="https"
          urlComponents.path="/search"
          urlComponents.query="term=張惠妹&media=music"
          if let url = urlComponents.url {
              URLSession.shared.dataTask(with: url) { (data, response , error) in
                  let decoder = JSONDecoder()
                  if let data = data, let songResults = try? decoder.decode(SongResults.self, from: data) {
                      self.songs = songResults.results
                  }
              }.resume()
            
          }
          
      }

    
    var body: some View {

        NavigationView {
            List(songs.indices, id: \.self) { (index)  in
                NavigationLink(destination: SongDetail(song: self.songs[index])) {
                    SongRow(song: self.songs[index])

                }
                
            }
            .onAppear {
                if self.songs.count == 0 {
                    self.fetchSongs()

                }
            }
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
