
import UIKit
import ReachabilitySwift

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, TelestraViewModelDelegate{
    
    var headerView:UIView!
    var titleLabel:UILabel!
    var imageTableView:UITableView!
    var refreshControl:UIRefreshControl!
    var titleArr: [String] = []
    var descriptionArr = [String]()
    var imageArr = [String]()
    var dataArray = [TestModel]()
    
    var viewModelObject = TelestraViewModel()
    var titleStr: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModelObject.delegate = self
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
        imageTableView.separatorStyle = .singleLine
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
        self.imageTableView.separatorColor = UIColor.black
        imageTableView.separatorStyle = .singleLine
        imageTableView.addSubview(refreshControl)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.refresh(())
    }
    

    @objc func refresh(_ sender:Any) {
        self.viewModelObject.makeTheAPIcall()
        DispatchQueue.main.async {
            self.imageTableView.reloadData()
            self.refreshControl.endRefreshing()
        }
    }
    
    func title(titleStr: String) {
        DispatchQueue.main.async {
            self.titleLabel.text = titleStr
            self.titleStr = titleStr
        }
    }
    
    //getting data for table view 
    func getTableData(dataArray: [TestModel]){
        self.dataArray = dataArray
        DispatchQueue.main.async {
            self.imageTableView.reloadData()
        }
    }
    
    func errorAlert(message:String){
        let alert = UIAlertController(title: "alert", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Click", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TestTableViewCell
        let currentObject = self.dataArray[indexPath.row]
        cell.nameLabel.text = currentObject.title
        cell.nameLabel.textAlignment = .left
        cell.nameLabel?.font = UIFont(name:"HelveticaNeue-Bold", size: 25.0)
        cell.descriptionLabel.text = currentObject.description
        if currentObject.cachedImage != nil {
            cell.imageVw.image = currentObject.cachedImage
        }
        else if let imageRefLink = currentObject.imageLink {
            DispatchQueue.global(qos: .background).async { [weak self] in
                
                guard let strongSelf = self else {
                    DispatchQueue.main.async {
                        cell.imageVw.image = UIImage(named: "noimage");
                    }
                    return
                }
                let imageUrl = URL(string: imageRefLink)
                do {
                    if let data = try? Data(contentsOf: imageUrl!)
                    {
                        if let finalimg:UIImage = UIImage(data: data) {
                            
                            var cachedObj = strongSelf.dataArray[indexPath.row]
                            cachedObj.cachedImage = finalimg
                            DispatchQueue.main.async {
                                cell.imageVw.image = finalimg
                            }
                        }
                        else {
                            DispatchQueue.main.async {
                                cell.imageVw.image = UIImage(named: "noimage");
                            }
                        }
                    }
                    else {
                        DispatchQueue.main.async {
                            cell.imageVw.image = UIImage(named: "noimage")
                        }
                    }
                }
            }
        }
        else {
            cell.imageVw.image = UIImage(named: "noimage")
        }
        cell.sizeToFit()
        return cell
    }
}
