//
//  EmojiController.swift
//  surveypart2
//
//  Created by Brian Licea on 10/5/17.
//  Copyright © 2017 Brian Licea. All rights reserved.
//

import Foundation

class SurveyController{
    static let shared = SurveyController()
    
    // Mark: - source off truth
    var surveys: [Survey] = []
    
    /*
     the empty completion is a great way to notify the caller of the function that you are done rnning yor code. you can complete with an object or an array of objects when the call needs to access them. both options give you the benefit of knowing exactly when that func is done running this is always nice when you are running async code.because you dont know how long it will take
     */
    
    private let baseURL = URL(string: "https://favemoji-f3689.firebaseio.com/")
    
    func putSurvey(with name: String, emoji: String, completion: @escaping(_ success: Bool) -> Void) {
        
        // creat an instance of survey
        let survey = Survey(name: name, emoji: emoji)
        
        guard let url = baseURL else { fatalError("Bad url")}
        
        // build the url
        let requestURL = url.appendingPathExtension("json")
        
        // create the request
        var request = URLRequest(url: requestURL)
        request.httpMethod = "PUT"
        request.httpBody = survey.jsondata
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            var success = false
            
            defer { completion(success) }
            
            //some super duoer error handling
            if let error = error {
                print("request is broken\(error.localizedDescription)\(#function)")
                
            }
            guard let data = data,
                let responseDataString = String(data: data, encoding: .utf8) else { return }
            if let error = error{
                print("Error: \(error.localizedDescription)\(#function)")
            } else {
                print("Successfully saved data to endpoint \(responseDataString)")
            }
            // add survey to our source of truth
            self.surveys.append(survey)
            
            success = true
            
            
        }.resume()
        
    }
    
    func fetchEmoji(completion: @escaping ([Survey]?) -> Void) {
        guard let url = baseURL?.appendingPathExtension("json") else {
            completion([])
            return
        }
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            if let error = error{
                print("\(error.localizedDescription)\(#function)\(#file)")
                completion([])
                return
            }
            guard let data = data else {
                print("no data returned from data task")
                completion([])
                return
            }
            
            // serialize our data
            guard let surveyDictionaries = (try? JSONSerialization.jsonObject(with: data, options: []) as? [String: [String: String]]) else {
                print("fetching from object")
                completion([])
                return
            }
            
            guard let surveys = surveyDictionaries?.flatMap({Survey(dictionary: $0.value, identifier: $0.key)}) else { return }
            
            self.surveys = surveys
            completion(surveys)
        }.resume()
    }
}
