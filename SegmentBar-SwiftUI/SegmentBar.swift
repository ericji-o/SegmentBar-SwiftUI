//
//  ContentView.swift
//  SegmentBar-SwiftUI
//
//  Created by  Eric on 2020/10/02.
//  Copyright © 2020  Eric. All rights reserved.
//

import SwiftUI

struct SegmentBar: View {
    
    @State private var selectedIndex = 0
    let padding: CGFloat = 10
    
    var items: [SegmentItem] = [
        SegmentItem(id: 0, title: "one"),
        SegmentItem(id: 1, title: "two"),
        SegmentItem(id: 2, title: "three"),
        SegmentItem(id: 3, title: "four"),
        SegmentItem(id: 4, title: "five"),
    ]
    
    var body: some View {
        GeometryReader { geo in
          self.setupUI(geo)
        }
    }
    
    private func setupUI(_ geo: GeometryProxy) -> some View {
        let itemWidth = geo.size.width/CGFloat(self.items.count)
        let itemCount = self.items.count
        let oddOffSet: CGFloat = itemCount % 2 == 0 ? 0.5 : 0.0 // because line start from the center. here is an offset for calculation
        return VStack(spacing: 0) {
              HStack(spacing: 0) {
                  ForEach(self.items, id: \.id) { item in
                      Text(item.title)
                          .frame(width: itemWidth, height: 50)
                        .onTapGesture {
                            self.selectedIndex = item.id
                    }
                  }
              }
                              
              HStack {
                  LineView()
                    .frame(width: itemWidth - self.padding)
                      .animation(.spring(response: 0.55, dampingFraction: 0.5, blendDuration: 0))
                      .transition(.slide)
                    .offset(x: CGFloat(self.selectedIndex) * itemWidth - CGFloat(CGFloat(Int(itemCount / 2)) - oddOffSet) * itemWidth, y: 0)
              }
        }
    }

}

fileprivate struct LineView: View {
    let color: Color = .red
    let width: CGFloat = 2
    var body: some View {
        Rectangle()
            .fill(color)
            .frame(height: width)
    }
}

struct SegmentItem: Identifiable {
    var id: Int
    var title: String
}

struct SegmentBar_Previews: PreviewProvider {
    static var previews: some View {
        SegmentBar()
    }
}

