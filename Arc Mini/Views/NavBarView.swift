//
//  NavBarView.swift
//  Arc Mini
//
//  Created by Matt Greenfield on 5/4/20.
//  Copyright © 2020 Matt Greenfield. All rights reserved.
//

import SwiftUI

struct NavBarView: View {

    @EnvironmentObject var timelineState: TimelineState

    var body: some View {
        HStack {
            Spacer().frame(width: 8)
            self.backButton.opacity(self.timelineState.backButtonHidden ? 0 : 1)
            Spacer()
            self.todayButton.opacity(self.timelineState.todayButtonHidden ? 0 : 1)
            Spacer().frame(width: 8)
        }.padding(.top, 12)
    }

    var backButton: some View {
        Button(action: {
            self.timelineState.tappedBackButton = true
        }) {
            Image(systemName: "chevron.left").foregroundColor(.white)
        }
        .frame(width: 40, height: 40)
        .background(Color.black.opacity(0.38))
        .cornerRadius(20)
    }

    var todayButton: some View {
        Button(action: {
            self.tappedTodayButton()
        }) {
            Image(systemName: "chevron.right.2").foregroundColor(.white)
        }
        .frame(width: 40, height: 40)
        .background(Color.black.opacity(0.38))
        .cornerRadius(20)
    }

    func tappedTodayButton() {
        timelineState.currentCardIndex = timelineState.dateRanges.count - 1
    }

}

struct NavBarView_Previews: PreviewProvider {
    static var previews: some View {
        NavBarView()
    }
}
