
import UIKit

class TestTableViewCell: UITableViewCell {
    
    var nameLabel:UILabel!
    var descriptionLabel:UILabel!
    var imageVw:UIImageView!
    
    override init(style:UITableViewCellStyle, reuseIdentifier:String?) {
        super.init(style:style, reuseIdentifier:reuseIdentifier)
        nameLabel = UILabel()
        imageVw = UIImageView()
        let marginGuide = contentView.layoutMarginsGuide
        contentView.addSubview(nameLabel)
        contentView.addSubview(imageVw)
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        nameLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        nameLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        nameLabel.heightAnchor.constraint(equalToConstant: 30)
        
        descriptionLabel = UILabel()
        contentView.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.leadingAnchor.constraint(equalTo: imageVw.trailingAnchor).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        descriptionLabel.textAlignment = .left
        descriptionLabel.sizeToFit()
        descriptionLabel.numberOfLines = 0
        
        imageVw.translatesAutoresizingMaskIntoConstraints = false
        imageVw.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        imageVw.topAnchor.constraint(equalTo: nameLabel.bottomAnchor).isActive = true
        imageVw.widthAnchor.constraint(equalToConstant: 100).isActive = true
        imageVw.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        imageVw.contentMode = .scaleAspectFit
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
