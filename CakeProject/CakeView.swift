//
//  CakeView.swift
//  CakeProject
//
//  Created by pink on 2022/3/15.
//

import SwiftUI
import Combine

class CakeModel: ObservableObject {
    @Published var state: CakeState = .unselect
}

enum CakeState{
    case unselect
    case didselect(item: CakeItem)
    var message: String{
        switch self {
        case .unselect:
            return "未選擇"
        case .didselect(let item):
            return "已選擇 - \(item.title)"
        }
    }
}

struct CakeView : View {
    @EnvironmentObject var model: CakeModel
    var body: some View {
        VStack(spacing: 12) {
            Spacer()
            Text("Cake List - \(model.state.message)")
                .font(.system(size: 32))
                .foregroundColor(.gray)
                .minimumScaleFactor(0.5)
                .padding(.trailing, 24)
                .frame(
                    minWidth: 0,
                    maxWidth: .infinity,
                    alignment: .trailing)
            CakeButtonRow(row: [.strawberry, .cocolate, .cheese])
                .padding(.bottom)
            CakeButtonRow(row: [.cocolate, .cheese, .strawberry])
                .padding(.bottom)
        }
    }
}

struct CakeView_Previews : PreviewProvider {
    static var previews: some View {
        Group {
            CakeView().environmentObject(CakeModel())
            CakeView().previewDevice("iPhone 13").environmentObject(CakeModel())
            CakeView().previewDevice("iPad Air 2").environmentObject(CakeModel())
        }
    }
}

struct CakeButtonRow : View {
    @EnvironmentObject var model: CakeModel
    let row: [CakeItem]
    var body: some View {
        HStack {
            ForEach(row, id: \.self) { item in
                CakeButton(
                    title: item.title,
                    backgroundColor: item.backgroundColor)
                {
                    model.state = .didselect(item: item)
                    print("Button: \(item.title)")
                }
            }
        }
    }
}

struct CakeButton : View {
    let title: String
    let backgroundColor: Color
    let action: () -> Void
    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 16))
                .foregroundColor(.white)
                .frame(width: 120, height: 30)
                .background(backgroundColor)
                .cornerRadius(30/2)
        }
    }
}

enum CakeItem: String {

    case strawberry
    case cocolate
    case cheese

    var title: String {
        switch self {
        case .strawberry: return "Strawberry"
        case .cocolate: return "Cocolate"
        case .cheese: return "Cheese"
        }
    }

    var backgroundColor: Color {
        switch self {
        case .strawberry: return .pink
        case .cocolate: return .brown
        case .cheese: return .yellow
        }
    }
}

extension CakeItem: Hashable {}

