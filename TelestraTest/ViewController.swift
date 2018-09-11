
import UIKit
import ReachabilitySwift

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource,telestraViewModelDelegate,AlertDelegate{
    
    var headerView:UIView!
    var titleLabel:UILabel!
    var imageTableView:UITableView!
    var refreshControl:UIRefreshControl!
    var titleArr: [String] = []
    var descriptionArr = [String]()
    var imageArr = [String]()
    
    var viewModelObject = TelestraViewModel()
    var serviceObj = Service()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModelObject.delegate = self
        serviceObj.protocolDelagate = self
        self.view.backgroundColor = UIColor.white
        
        //Adding refreshing control
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        headerView = UIView()
        headerView.backgroundColor = UIColor.red
        self.view.addSubview(headerView)
        
        
        //Adding Table View to load the data with
        imageTableView = UITableView()
        imageTableView.register(TestTableViewCell.self, forCellReuseIdentifier:"Cell")
        imageTableView.dataSource = self
        imageTableView.delegate = self
        imageTableView.estimatedRowHeight = 100
        imageTableView.rowHeight = UITableViewAutomaticDimension
        self.view.addSubview(imageTableView)
        
        //Adding Label for title
        titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: titleLabel.font.fontName, size: 20)
        headerView.addSubview(titleLabel)
        
        //Autolayout for header
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        headerView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        headerView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier:1).isActive = true
        headerView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        
        //Autolayout for title in
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: headerView.widthAnchor, multiplier: 0.5).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: headerView.heightAnchor, multiplier:0.5).isActive = true
        
        //Autolayout for TableView
        imageTableView.translatesAutoresizingMaskIntoConstraints = false
        imageTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        imageTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        imageTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive  = true
        imageTableView.topAnchor.constraint(equalTo: self.headerView.bottomAnchor).isActive = true
        imageTableView.addSubview(refreshControl)
        
    }
    

        @objc func refresh(_ sender:Any){
        _ = TelestraViewModel()
        DispatchQueue.main.async {
            self.imageTableView.reloadData()
             self.refreshControl.endRefreshing()
        }
       
    }
    
    func title(data:Title){
        DispatchQueue.main.async {
            self.titleLabel.text = data.mainTitle
        }
    }
    
    //getting data for table view 
    func getTableData(data: [TestModel]){
        for items in data{
            if let description = items.description
            {
                self.descriptionArr.append(description)
            }
            if let image = items.image
            {
                self.imageArr.append(image)
            }
            if let title = items.title
            {
                self.titleArr.append(title)
            }
        }
        DispatchQueue.main.async {
            self.imageTableView.reloadData()
        }
    }
    
    func presentPoPup(massage: String){
        let alert = UIAlertController(title: "alert", message: massage, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TestTableViewCell
        cell.nameLabel.text = self.titleArr[indexPath.row]
        cell.nameLabel.backgroundColor = UIColor.gray
        cell.descriptionLabel.text = self.descriptionArr[indexPath.row]
        DispatchQueue.global(qos: .background).async { [weak self] in
            let value = self?.imageArr[indexPath.row]
            let url = URL(string: value!)
            if let data = try? Data(contentsOf: url!)
            {
                if let finalimg:UIImage = UIImage(data: data){
                    DispatchQueue.main.async{
                        cell.imageVw.image = finalimg
                    }
                }
                
            }
            
        }
        cell.sizeToFit()
        return cell
    }
}
