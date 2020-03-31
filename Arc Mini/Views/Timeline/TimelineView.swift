//
//  TimelineView.swift
//  Arc Mini
//
//  Created by Matt Greenfield on 6/3/20.
//  Copyright © 2020 Matt Greenfield. All rights reserved.
//

import SwiftUI
import LocoKit

struct TimelineView: View {

    @ObservedObject var timelineSegment: TimelineSegment
    @EnvironmentObject var mapState: MapState

    init(segment: TimelineSegment) {
        self.timelineSegment = segment
        UITableView.appearance().separatorStyle = .none
        UITableViewCell.appearance().selectionStyle = .none
        UINavigationBar.appearance().tintColor = .arcSelected
//        UINavigationBar.appearance().isTranslucent = false // causes crash

        let barAppearance = UINavigationBarAppearance()
        barAppearance.shadowColor = .clear
        UINavigationBar.appearance().standardAppearance = barAppearance
        UINavigationBar.appearance().scrollEdgeAppearance = barAppearance
    }

    var body: some View {
        GeometryReader { metrics in
            NavigationView {
                List {
                    Section(header: TimelineHeader().frame(width: metrics.size.width)) {
                        ForEach(self.filteredListItems) { timelineItem in
                            ZStack {
                                self.listBox(for: timelineItem)
                                NavigationLink(destination: ItemDetailsView(timelineItem: timelineItem)) {
                                    EmptyView()
                                }
                                .buttonStyle(PlainButtonStyle())
                            }
                        }
                    }
                }
                .navigationBarTitle("")
                .navigationBarHidden(true)
                .onAppear {
                    self.mapState.selectedItems.removeAll()
                    self.mapState.itemSegments.removeAll()
                }
            }
        }
    }

    // TODO: need "thinking..." boxes represented in the list array somehow
    var filteredListItems: [TimelineItem] {
        return self.timelineSegment.timelineItems.reversed().filter { $0.dateRange != nil }
    }

    func listBox(for timelineItem: TimelineItem) -> AnyView {
        if let visit = timelineItem as? ArcVisit {
            return AnyView(VisitListBox(visit: visit)
                .listRowInsets(EdgeInsets()))
        }
        if let path = timelineItem as? ArcPath {
            return AnyView(PathListBox(path: path)
                .listRowInsets(EdgeInsets()))
        }
        fatalError("nah")
    }

}

//struct TimelineView_Previews: PreviewProvider {
//    static var previews: some View {
//        TimelineView(segment: AppDelegate.todaySegment)
//    }
//}
