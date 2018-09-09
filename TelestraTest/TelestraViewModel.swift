
import Foundation

protocol telestraViewModelDelegate:class{
    func getTableData(data: [TestModel])
    func title(data:Title)
}
class TelestraViewModel:serviceDelegate{
    
    var serviceObj = Service()
    weak var delegate:telestraViewModelDelegate?
    
    init(){
        serviceObj.delegate = self
        serviceObj.getAPIDetails()
    }
    
    func getTitle(title: Title){
        self.delegate?.title(data: title)
    }
    
    func getApiDetails(jsonObject:[TestModel]){
        var itemArray = [TestModel]()
        for items in jsonObject{
            var itemObj = TestModel()
            if let item = items.description{
                itemObj.description = item
            }
            if let item = items.image{
                itemObj.image = item
            }
            if let item = items.title{
                itemObj.title = item
            }
            itemArray.append(itemObj)
        }
        self.delegate?.getTableData(data: itemArray)
    }
    
}
