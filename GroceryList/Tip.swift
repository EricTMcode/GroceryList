//
//  Tip.swift
//  GroceryList
//
//  Created by Eric on 21/03/2025.
//

import Foundation
import TipKit

struct ButtonTip: Tip {
    var title: Text = Text("Essential Foods")
    var message: Text? = Text("Add some everyday items to the shopping list.")
    var image: Image? = Image(systemName: "info.circle")
}
