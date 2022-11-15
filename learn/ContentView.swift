//
//  ContentView.swift
//  learn
//
//  Created by 顾艳华 on 2022/11/9.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: ViewModel
    let e = ["😜", "😀", "😄", "😆", "🥹", "🥰"]
    var body: some View {
        VStack {
            AspectView(cards: viewModel.model.cards) { card in
                if card.isMacthed && !card.isFaceUp {
                    Rectangle().opacity(0)
                } else {
                    CardView(card: card).onTapGesture {
                        viewModel.select(card)
                    }
                }
                
            }
        }
        .padding(.horizontal)
    }
}

struct AspectView<Item: Identifiable, IV: View>: View {
    var cards: [Item]
    var content: (Item) -> IV
    init(cards: [Item], @ViewBuilder content: @escaping (Item) -> IV) {
        self.cards = cards
        self.content = content
    }
    var body: some View {
        ScrollView {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 80))]) {
                ForEach(cards){
                    card in content(card).aspectRatio(2/3, contentMode: .fit)
                }
            }
            .foregroundColor(.red)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = ViewModel()
        ContentView(viewModel: vm)
        ContentView(viewModel: vm)
            .preferredColorScheme(.dark)
    }
}

struct CardView: View {
    var card: Model<String>.Card
    var body: some View {
        GeometryReader {
            g in
            ZStack {
                Text(card.c).font(Font.system(size: min(g.size.height, g.size.width) * 0.8))
                Pie(startAngle: Angle(degrees: 0 - 90), endAngle: Angle(degrees: 110 - 90)).opacity(0.4)
            }.cardify(isFaceUp: card.isFaceUp)
        }
    }
}
