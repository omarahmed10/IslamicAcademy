
import UIKit

class CenterViewController: UIViewController {
    
    var delegate : CenterViewControllerDelegate?
    
    @IBAction func sidePanClicked(_ sender: Any) {
        delegate?.toggleLeftPanel?()
    }
}
