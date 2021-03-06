
import UIKit

class TestTableViewCell: UITableViewCell {
    
    var nameLabel:UILabel!
    var descriptionLabel:UILabel!
    var imageVw:UIImageView!
    
    override init(style:UITableViewCellStyle, reuseIdentifier:String?) {
        super.init(style:style, reuseIdentifier:reuseIdentifier)
        nameLabel = UILabel()
        descriptionLabel = UILabel()
        imageVw = UIImageView()
        let marginGuide = contentView.layoutMarginsGuide
        contentView.addSubview(nameLabel)
        contentView.addSubview(imageVw)
        
        //Adding layout for images in cell
        imageVw.translatesAutoresizingMaskIntoConstraints = false
        imageVw.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
    
        imageVw.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        imageVw.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageVw.heightAnchor.constraint(equalToConstant: 100).isActive = true
        imageVw.contentMode = .scaleAspectFit
        
        //Adding layout for Title in cell
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor, constant: 30).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        
        //Adding layout for description in cell
        contentView.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: imageVw.bottomAnchor).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        descriptionLabel.textAlignment = .left
        descriptionLabel.sizeToFit()
        descriptionLabel.numberOfLines = 0
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder:aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
}
