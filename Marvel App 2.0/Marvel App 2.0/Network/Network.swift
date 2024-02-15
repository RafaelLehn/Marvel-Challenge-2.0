//
//  Network.swift
//  Marvel App 2.0
//
//  Created by Evolua Tech on 2/8/24.
//

import Foundation
import Network


protocol NetworkService: AnyObject {
    func fetchCharacters(numberOffset: Int, completion: @escaping (CharacterModel?, [Character]?, String?) -> Void)
}

class Network: NetworkService {
    
    let monitor = NWPathMonitor()

    func verifyInternet(completion: @escaping (NWPath.Status) -> Void) {
        let queue = DispatchQueue(label: "NetworkMonitor")
        monitor.start(queue: queue)
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                print("Internet connection is available.")
                // Perform actions when internet is available
            } else {
                print("Internet connection is not available.")
                // Perform actions when internet is not available
            }
            completion(path.status)
        }
        
    }
    
    func fetchCharacters(numberOffset: Int, completion: @escaping (CharacterModel?, [Character]?, String?) -> Void) {
        
        let defaultSession = URLSession(configuration: .default)
        
        let timeStamp = "1583951490"
        let keypublic = "5ecf657af4a5551d096d49e4f2ffc724"
        let hash = "06de60a1cb99dc30a2854659c63d6a42"
        
        
        if let url = URL(string: "https://gateway.marvel.com/v1/public/characters?ts=\(timeStamp)&apikey=\(keypublic)&hash=\(hash)&offset=\(numberOffset)&limit=100") {
            
            let request = URLRequest(url:url)
            let dataTask = defaultSession.dataTask(with: request, completionHandler: { (data, response, error) -> Void in
                
                guard error == nil else {
                    print ("error: ", error!)
                    completion(nil, nil, error?.localizedDescription)
                    return
                }
                
                guard data != nil else {
                    print("No data object")
                    completion(nil, nil, error?.localizedDescription)
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                    print("response is: ", response!)
                    completion(nil, nil, error?.localizedDescription)
                    return
                }
                
                guard let mime = response?.mimeType, mime == "application/json" else {
                    print("Wrong MIME type!")
                    completion(nil, nil, "Wrong MIME type!")
                    return
                }
                
                DispatchQueue.main.async {
                    
                    guard let result = try? JSONDecoder().decode(CharacterModel.self, from: data!) else {
                        print("Error Parsing JSON")
                        completion(nil, nil, "Error Parsing JSON")
                        return
                    }
                    
                    let characters: [Character]?
                    characters = result.data.results
                    
                    DispatchQueue.main.async {
                        completion(result, characters, nil)
                    }
                }
            })
            dataTask.resume()
        }
    }
}
