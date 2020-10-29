//
//  StoryListViewModel.swift
//  swiftUICombHacker
//
//  Created by Greg Hughes on 10/28/20.
//

import Foundation
import Combine

class StoryListViewModel: ObservableObject {
    //When this is set, it updates the story lists with the new fetched stories
    @Published var stories = [StoryViewModel]()
     var cancellable: AnyCancellable?
    
    init() {
        fetchTopStories()
    }
    
    func fetchTopStories() {
        self.cancellable = Webservice().getAllTopStories()
            .map { stories in
            stories.map{ StoryViewModel(story: $0) }
            
        }.sink(receiveCompletion: {_ in}, receiveValue: { storyViewModels in
            self.stories = storyViewModels
        })
    }
}

struct StoryViewModel:Identifiable {
    let story: Story
    var id: Int {
        return self.story.id
    }
    var title: String {
        return self.story.title
    }
    var url: String {
        return self.story.url
    }
}
