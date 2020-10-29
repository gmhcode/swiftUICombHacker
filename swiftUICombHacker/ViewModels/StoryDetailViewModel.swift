//
//  StoryDetailViewModel.swift
//  swiftUICombHacker
//
//  Created by Greg Hughes on 10/28/20.
//

import Foundation
import Combine
class StoryDetailViewModel: ObservableObject {
    
    
    private var cancellable: AnyCancellable?
    
    //The url and title will supposedly change when this gets changed
    @Published private var story = Story.placeholder()
    
    
    
     func fetchStoryDetails(storyId: Int){
        print("about to make a network request")
        self.cancellable = Webservice().getStoryByID(storyID: storyId)
            .catch{_ in
                Just(Story.placeholder())}
            .sink(receiveCompletion: {_ in}, receiveValue: { story in
                self.story = story
            })
    }
}

extension StoryDetailViewModel {
    
    var title: String {
        return self.story.title
    }
    var url: String {
        return self.story.url
    }
    
}
