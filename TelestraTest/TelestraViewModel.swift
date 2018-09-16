
import Foundation

protocol TelestraViewModelDelegate:class{
    func getTableData(dataArray: [TestModel])
    func title(titleStr:String)
    func errorAlert(message:String)
}

class TelestraViewModel:serviceDelegate{
    
    var serviceObj = Service()
    weak var delegate:TelestraViewModelDelegate?
    
    init(){
        serviceObj.serviceDelegate = self
    }
    
    func makeTheAPIcall() {
        serviceObj.getAPIDetails()
    }
    
    //processing data for main title
    func getTitle(title: String){
        self.delegate?.title(titleStr: title)
    }
    
    // processing  data for table view and sending to viewcontroller
    func getApiDetails(jsonObject:[TestModel]) {
         self.delegate?.getTableData(dataArray: jsonObject)
    }
    
    func presentPoPup(massage: String){
        self.delegate?.errorAlert(message: massage)
    }
    
}
