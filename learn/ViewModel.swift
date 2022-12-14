//
//  ViewModel.swift
//  learn
//
//  Created by ι‘Ύθ³ε on 2022/11/11.
//

import Foundation
class ViewModel: ObservableObject {
    @Published var model: Model<String>
    static let e = ["π", "π", "π", "π", "π₯Ή", "π₯°"]
    init() {
        model = Model(num: ViewModel.e.count) {
            i in ViewModel.e[i]
        }
    }
    
    func select(_ card: Model<String>.Card) {
        model.select(card)
    }
}
