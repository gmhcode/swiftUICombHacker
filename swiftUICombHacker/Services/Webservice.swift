//
//  Webservice.swift
//  swiftUICombHacker
//
//  Created by Greg Hughes on 10/28/20.
//

import Foundation
import Combine
class Webservice {
    
    func getStoryByID(storyID: Int) -> AnyPublisher<Story,Error> {
        guard let url = URL(string: "https://hacker-news.firebaseio.com/v0/item/\(storyID).json?print=pretty") else {fatalError("❇️♊️>>>\(#file) \(#line): guard let failed<<<")}
        
         return URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .decode(type: Story.self, decoder: JSONDecoder())
            .receive(on: RunLoop.main)
            .eraseToAnyPublisher()
    }
    //I think this just merges the stories with their ids
    private func mergeStories(ids storyIds: [Int]) -> AnyPublisher<Story,Error> {
        let storyIds = Array(storyIds.prefix(50))
        let initialPublisher = getStoryByID(storyID: storyIds[0])
        let remainder = Array(storyIds.dropFirst())
        
        return remainder.reduce(initialPublisher) { combined, id in
            return combined.merge(with: getStoryByID(storyID: id))
                .eraseToAnyPublisher()
        }
    }
    
    
    func getAllTopStories() -> AnyPublisher<[Story],Error> {
        guard let url = URL(string: "https://hacker-news.firebaseio.com/v0/topstories.json?print=pretty") else {fatalError("❇️♊️>>>\(#file) \(#line): guard let failed<<<")}

        return  URLSession.shared.dataTaskPublisher(for: url)
            .map(\.data)
            .receive(on: RunLoop.main)
            .decode(type: [Int].self, decoder: JSONDecoder())
            .flatMap{ storyIds in
                //fetches the actual stories with the storyIds
                
                return self.mergeStories(ids: storyIds)
            }.scan([], { stories, story -> [Story] in
                //For each story PUBLISHER in the flatmap, this will extract the stories and put them in an array
                return stories + [story]
            })
            .eraseToAnyPublisher()
    }
}
