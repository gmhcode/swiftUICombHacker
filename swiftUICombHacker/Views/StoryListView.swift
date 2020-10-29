//
//  StoryListView.swift
//  swiftUICombHacker
//
//  Created by Greg Hughes on 10/28/20.
//

import SwiftUI
import Combine
struct StoryListView: View {
    
    @ObservedObject var storyListVM = StoryListViewModel()
    
    var body: some View {
        
        NavigationView{
            List(self.storyListVM.stories, id: \.id) { storyVM in
                NavigationLink(
                    destination: StoryDetailView(storyId: storyVM.id),
                    label: {
                        Text("\(storyVM.title)")
                    })
                
            }
            .navigationBarTitle("Hacker News")
        }
    }
}

struct StoryListView_Previews: PreviewProvider {
    static var previews: some View {
        StoryListView()
    }
}
