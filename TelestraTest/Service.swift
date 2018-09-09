
import Foundation

protocol serviceDelegate:class{
    func getApiDetails(jsonObject:[TestModel])
    func getTitle(title: Title)
}

class Service{
    
    var titleObj = Title()
    weak var delegate:serviceDelegate?
    
    func getAPIDetails(){
        
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
                    print("network error")
                    return
            }
            guard let responseData = data else{
                print("unable to get the data")
                return
            }
            if let text = String(data: responseData, encoding: String.Encoding.ascii)
            {
                if let data = text.data(using: .utf8) {
                    do {
                        guard let jsonObj = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] else {return}
                        print(jsonObj)
                        if let title = jsonObj["title"] as! String?{
                            titleObject.mainTitle = title
                        }
                        guard let row = jsonObj["rows"] as? NSArray else {return}
                        print(row)
                        
                        for items in row{
                            var modelObj = TestModel()
                            guard let dictObject = items as? NSDictionary else{return}
                            if let description = dictObject["description"] as? String
                            {
                                print(description)
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
                        print(model.description)
                        self.delegate?.getApiDetails(jsonObject: model)
                        self.delegate?.getTitle(title: titleObject)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
        task.resume()
        
    }
}

