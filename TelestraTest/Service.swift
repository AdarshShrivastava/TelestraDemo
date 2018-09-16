
import Foundation
import ReachabilitySwift

protocol serviceDelegate:class{
    func getApiDetails(jsonObject:[TestModel])
    func getTitle(title: String)
    func presentPoPup(massage: String)
}

class Service{
    
    weak var serviceDelegate:serviceDelegate?
    
    // service call
    func getAPIDetails(){
        
        ReachibilityManager.shared.addListener(listener: self)
        ReachibilityManager.shared.startMonitoring()
        
        if(ReachibilityManager.shared.isInternetAvailable()){
            var modelArray = [TestModel]()
            let str = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
            guard let url = URL(string: str) else {
                print("unable to convert to url")
                return
            }
            let request = URLRequest(url: url)
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                guard error == nil
                    else{
                        self.serviceDelegate?.presentPoPup(massage: "network Error")
                        return
                }
                guard let responseData = data else{
                    self.serviceDelegate?.presentPoPup(massage: "unable to get data")
                    return
                }
                if let text = String(data: responseData, encoding: String.Encoding.ascii)
                {
                    if let data = text.data(using: .utf8) {
                        
                        do {
                            guard let jsonObj = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {return}
                            if let titleStr = jsonObj["title"] as! String? {
                                self.serviceDelegate?.getTitle(title: titleStr)
                            }
                            
                            guard let row = jsonObj["rows"] as? NSArray else {return}
                            for items in row {
                                var modelObj = TestModel()
                                guard let dictObject = items as? NSDictionary else{return}
                                if let title = dictObject["title"] as? String
                                {
                                    modelObj.title = title
                                }
                                else {
                                    modelObj.title = ""
                                }
                                
                                if let description = dictObject["description"] as? String
                                {
                                    modelObj.description = description
                                }
                                else {
                                    modelObj.description = ""
                                }
                                
                                if let photo = dictObject["imageHref"] as? String
                                {
                                    modelObj.imageLink = photo
                                }
                                
                                
                                modelArray.append(modelObj)
                                
                            }
                            self.serviceDelegate?.getApiDetails(jsonObject: modelArray)
                            
                            print("\n\n\ndata recieved from server\n\n\n")
                        } catch {
                            self.serviceDelegate?.presentPoPup(massage: error.localizedDescription)
                        }
                    }
                }
            }
            task.resume()
            
        }
            
        else{
            self.serviceDelegate?.presentPoPup(massage: "Network not available")
        }
    }
}

extension Service: NetworkStatusListener {
    
    func networkStatusDidChange(status: Reachability.NetworkStatus) {
        
        switch status {
        case .notReachable:
            self.serviceDelegate?.presentPoPup(massage: "Network unreachable")
        case .reachableViaWiFi:
            break
        case .reachableViaWWAN:
            break
            
        }
    }
}

