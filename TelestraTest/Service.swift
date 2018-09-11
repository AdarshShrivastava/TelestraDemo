
import Foundation
import ReachabilitySwift

protocol serviceDelegate:class{
    func getApiDetails(jsonObject:[TestModel])
    func getTitle(title: Title)
}

protocol AlertDelegate:class{
    func presentPoPup(massage: String)
}

class Service{
    
    var titleObj = Title()
    weak var delegate:serviceDelegate?
    weak var protocolDelagate:AlertDelegate?
    
    // service call
    func getAPIDetails(){

        ReachibilityManager.shared.addListener(listener: self)
        var model = [TestModel]()
        var titleObject = Title()
        let str = "https://dl.dropboxusercontent.com/s/2iodh4vg0eortkl/facts.json"
        guard let url = URL(string: str) else {
            print("unable to convert to url")
            return
        }
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard error == nil
                else{
                    //print("network error")
                    self.protocolDelagate?.presentPoPup(massage: "network Error")
                    return
            }
            guard let responseData = data else{
                self.protocolDelagate?.presentPoPup(massage: "unable to get data")
                return
            }
            if let text = String(data: responseData, encoding: String.Encoding.ascii)
            {
                if let data = text.data(using: .utf8) {
                    do {
                        guard let jsonObj = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {return}
                        if let title = jsonObj["title"] as! String?{
                            titleObject.mainTitle = title
                        }
                        guard let row = jsonObj["rows"] as? NSArray else {return}
                        for items in row{
                            var modelObj = TestModel()
                            guard let dictObject = items as? NSDictionary else{return}
                            if let description = dictObject["description"] as? String
                            {
                                modelObj.description = description
                            }
                            if let photo = dictObject["imageHref"] as? String
                            {
                                modelObj.image = photo
                            }
                            if let title = dictObject["title"] as? String
                            {
                                modelObj.title = title
                            }
                            model.append(modelObj)
                            
                        }
                        self.delegate?.getApiDetails(jsonObject: model)
                        self.delegate?.getTitle(title: titleObject)
                    } catch {
                        self.protocolDelagate?.presentPoPup(massage: error.localizedDescription)
                    }
                }
            }
        }
        task.resume()
    }
}

extension Service: NetworkStatusListener {
    
    func networkStatusDidChange(status: Reachability.NetworkStatus) {
        
        switch status {
        case .notReachable:
            //debugPrint("ViewController: Network became unreachable")
            self.protocolDelagate?.presentPoPup(massage: "Network became unreachable")
        case .reachableViaWiFi:
            //debugPrint("ViewController: Network reachable through WiFi")
            self.protocolDelagate?.presentPoPup(massage: "Network reachable through WiFi")
        case .reachableViaWWAN:
            //debugPrint("ViewController: Network reachable through Cellular Data")
            self.protocolDelagate?.presentPoPup(massage: "Network reachable through Cellular Data")
        }
    }
}

