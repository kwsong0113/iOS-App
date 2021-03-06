//
//  ContentView.swift
//  Memorize
//
//  Created by user206692 on 11/12/21.
//

import SwiftUI

struct ContentView: View {
    @State var emojis = ["βοΈ", "π", "πΆ", "π", "π", "π²", "π", "π", "π", "π³", "π", "π ", "πΊ", "π", "π", "π¦½", "π΄", "πΈ", "β΅οΈ", "π©", "π°", "π", "π¦Ό", "π"].shuffled()
    @State var emojiCount = Int.random(in: 4...24)
    
    var body: some View {
        VStack {
            Text("Memorize!").font(.largeTitle)
            ScrollView {
                LazyVGrid(columns: [GridItem(.adaptive(minimum: 103 - 1.8 * CGFloat(emojiCount)))]) {
                    ForEach(emojis[0..<emojiCount], id: \.self) { emoji in
                        CardView(content: emoji)
                            .aspectRatio(2/3, contentMode: .fit)
                    }
                }
            }
            .foregroundColor(.red)
            Spacer()
            HStack {
                vehicles
                Spacer()
                countryFlags
                Spacer()
                animals
            }
            .font(.largeTitle)
            .padding(.horizontal, 50)
        }
        .padding(.horizontal)
    }
    var vehicles: some View {
        Button {
            emojis = ["βοΈ", "π", "πΆ", "π", "π", "π²", "π", "π", "π", "π³", "π", "π ", "πΊ", "π", "π", "π¦½", "π΄", "πΈ", "β΅οΈ", "π©", "π°", "π", "π¦Ό", "π"].shuffled()
            emojiCount = Int.random(in: 4...emojis.count)
        } label: {
            VStack {
                Image(systemName: "car")
                Text("Vehicles").font(.footnote)
            }
        }
    }
    
    var countryFlags: some View {
        Button {
            emojis = ["π¦π«", "π¦π½", "π©πΏ", "π¦πΊ", "π¦π²", "π§πͺ", "π¨π¦", "π§π·", "π΅π«", "π«π·", "π±π·", "π―π΅", "π―π²", "π―π΄", "π°π·", "πͺπΈ", "πΉπ·", "π¬π§", "πΎπͺ"].shuffled()
            emojiCount = Int.random(in: 4...emojis.count)
        } label: {
            VStack {
                Image(systemName: "flag")
                Text("Flags").font(.footnote)
            }
        }
    }
    
    var animals: some View {
        Button {
            emojis = ["πΌ", "π΅", "π£", "π¦", "π΄", "πΈ", "π·", "π―", "π»", "π¦", "πΆ", "π±", "π­", "π°"].shuffled()
            emojiCount = Int.random(in: 4...emojis.count)
        } label: {
            VStack {
                Image(systemName: "hare")
                Text("Animals").font(.footnote)
            }
        }
    }
    
//    var remove: some View {
//        Button {
//            if emojiCount > 1 {
//                emojiCount -= 1
//            }
//        } label: {
//            Image(systemName: "minus.circle")
//        }
//    }
//    var add: some View {
//        Button {
//            if emojiCount < emojis.count {
//                emojiCount += 1
//            }
//        } label: {
//            Image(systemName: "plus.circle")
//        }
//    }
}

struct CardView: View {
    var content: String
    @State var isFaceUp: Bool = true
    var body: some View {
        ZStack {
            let shape = RoundedRectangle(cornerRadius: 20)
            if isFaceUp {
                shape.fill().foregroundColor(.white)
                shape.strokeBorder(lineWidth: 3)
                Text(content).font(.largeTitle)
            } else {
                shape.fill()
            }
        }
        .onTapGesture {
            isFaceUp = !isFaceUp
        }
    }
}
















struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .preferredColorScheme(.dark)
        ContentView()
            .preferredColorScheme(.light)
    }
}
