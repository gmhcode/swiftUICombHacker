//
//  StoryDetailView.swift
//  swiftUICombHacker
//
//  Created by Greg Hughes on 10/28/20.
//

import SwiftUI

struct StoryDetailView: View {
    
    @ObservedObject private var storyDetailVM: StoryDetailViewModel
    var storyID: Int
    
    init(storyId:Int) {
        self.storyDetailVM = StoryDetailViewModel()
        self.storyID = storyId
    }
    
    var body: some View {
        VStack {
            Text(self.storyDetailVM.title)
            Webview(url: self.storyDetailVM.url)
        }.onAppear{
            self.storyDetailVM.fetchStoryDetails(storyId: self.storyID)
        }
    }
}

struct StoryDetailView_Previews: PreviewProvider {
    static var previews: some View {
        StoryDetailView(storyId: 100)
    }
}
