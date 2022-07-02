import UIKit

class CollectionProductsViewCell: UITableViewCell {

    static let cellIdentifier = "collectionProductsViewIdentifier"
    
    @IBOutlet weak var leftButon: UIButton!
    @IBOutlet weak var leftIconView: UIImageView!
    @IBOutlet weak var leftTitleLabel: UILabel!
    @IBOutlet weak var leftDetailLabel: UILabel!
    
    @IBOutlet weak var rightButon: UIButton!
    @IBOutlet weak var rightIconView: UIImageView!
    @IBOutlet weak var rightTitleLabel: UILabel!
    @IBOutlet weak var rightDetailLabel: UILabel!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        leftButon.removeTarget(nil, action: nil, for: .allEvents)
        leftIconView.image = nil
        leftTitleLabel.text = ""
        leftDetailLabel.text = ""
        
        rightButon.removeTarget(nil, action: nil, for: .allEvents)
        rightIconView.image = nil
        rightTitleLabel.text = ""
        rightDetailLabel.text = ""
    }
    
    func setup(model: CollectionProductModel) {
        leftIconView.image = UIImage(systemName: model.left.iconName)
        leftTitleLabel.text = model.left.title
        leftDetailLabel.text = model.left.detail
        
        rightIconView.image = UIImage(systemName: model.right.iconName)
        rightTitleLabel.text = model.right.title
        rightDetailLabel.text = model.right.detail
    }
}
