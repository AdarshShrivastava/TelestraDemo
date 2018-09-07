
import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    var headerView:UIView!
    var titleLabel:UILabel!
    var imageTableView:UITableView!
    var refreshControl:UIRefreshControl!
    var titleArr: [String] = []
    var descriptionArr = [String]()
    var imageArr = [String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.async {
            self.imageTableView.reloadData()
        }
        self.view.backgroundColor = UIColor.white
        
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        headerView = UIView()
        headerView.backgroundColor = UIColor.red
        self.view.addSubview(headerView)
        
        imageTableView = UITableView()
        imageTableView.register(TestTableViewCell.self, forCellReuseIdentifier:"Cell")
        imageTableView.dataSource = self
        imageTableView.delegate = self
        imageTableView.estimatedRowHeight = 100
        imageTableView.rowHeight = UITableViewAutomaticDimension
        self.view.addSubview(imageTableView)
        
        titleLabel = UILabel()
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont(name: titleLabel.font.fontName, size: 20)
        headerView.addSubview(titleLabel)
        
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        headerView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        headerView.widthAnchor.constraint(equalTo: self.view.widthAnchor, multiplier:1).isActive = true
        headerView.heightAnchor.constraint(equalTo: self.view.heightAnchor, multiplier: 0.1).isActive = true
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.centerXAnchor.constraint(equalTo: headerView.centerXAnchor).isActive = true
        titleLabel.bottomAnchor.constraint(equalTo: headerView.bottomAnchor).isActive = true
        titleLabel.widthAnchor.constraint(equalTo: headerView.widthAnchor, multiplier: 0.5).isActive = true
        titleLabel.heightAnchor.constraint(equalTo: headerView.heightAnchor, multiplier:0.5).isActive = true
        
        imageTableView.translatesAutoresizingMaskIntoConstraints = false
        imageTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        imageTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        imageTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive  = true
        imageTableView.topAnchor.constraint(equalTo: self.headerView.bottomAnchor).isActive = true
        imageTableView.addSubview(refreshControl)
        
    }
    
    @objc func refresh(_ sender:Any){
        imageTableView.reloadData()
        refreshControl.endRefreshing()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TestTableViewCell
        cell.nameLabel.text = self.titleArr[indexPath.row]
        cell.nameLabel.backgroundColor = UIColor.gray
        cell.descriptionLabel.text = self.descriptionArr[indexPath.row]
        let imageString = self.imageArr[indexPath.row]
        let url = URL(string: imageString)
        if let data = try? Data(contentsOf: url!)
        {
            if let finalimg:UIImage = UIImage(data: data){
                DispatchQueue.main.async{
                    cell.imageVw.image = finalimg
                }
            }
            
        }
        cell.sizeToFit()
        return cell
    }
    
    
}
