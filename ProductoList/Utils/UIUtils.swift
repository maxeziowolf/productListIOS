//
//  UIUtils.swift
//  ProductoList
//
//  Created by Maxeziowolf.
//

import Foundation

class UIUtils {
    
    // MARK: - Constants
    private let defaultSession = URLSession(configuration: .default)
    
    // MARK: - Variables And Properties
    private var dataTask: URLSessionDataTask?
    
    
    var errorMessage = ""
    
    // MARK: - Type Alias
    typealias QueryResult = (GenericResponse? , String) -> Void
    
    // MARK: - Internal Methods
    public func getInformation(completion: @escaping QueryResult){
        
        dataTask?.cancel()
        
        
        if let urlComponents = URLComponents(string: APICostans.urlBase) {
            
            guard let url = urlComponents.url else {
                return
            }
            
            dataTask = defaultSession.dataTask(with: url){ [weak self] data, response, error in
                
                defer {
                  self?.dataTask = nil
                }
                
                if let error = error {
                    
                    self?.errorMessage += "DataTask error: " + error.localizedDescription + "\n"
                    
                    
                } else if let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 {
                    
                    self?.updateSearchResults(data, completion: completion)
                    
                    
                }
                
            }
            
            dataTask?.resume()
            
        }
        
    }
    
    //
    // MARK: - Private Methods
    //
    private func updateSearchResults(_ data: Data, completion: @escaping QueryResult) {
      
      do {
        
        
        let response = try! JSONDecoder().decode(GenericResponse.self, from: data)
        
        completion(response,errorMessage)
        
      } catch let parseError as NSError {
        
        errorMessage += "JSONSerialization error: \(parseError.localizedDescription)\n"
        
        completion(nil, errorMessage)
        
        return
      }
        
        
    }
    
}
