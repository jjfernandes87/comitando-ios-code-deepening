import UIKit

class TitleViewCell: UITableViewCell {

    static let cellIdentifier = "titleViewCellIdentifier"
    
    @IBOutlet weak var titleLabel: UILabel!
    
    func setup(title: String) {
        titleLabel.text = title
    }
}
