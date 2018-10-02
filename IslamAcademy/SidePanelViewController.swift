import UIKit

protocol SidePanelSelectionDelegate {
    func selectFeed(with type : FeedType)
}

class SidePanelViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var menu = [FeedType.Main,FeedType.Article,FeedType.Audio,FeedType.Video]
    var delegate : SidePanelSelectionDelegate?
    enum CellIdentifiers {
        static let MenuCell = "MenuCell"
        static let SocialMediaCell = "SocialMediaCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
}

// MARK: Table View Data Source
extension SidePanelViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.SocialMediaCell, for: indexPath)
                return cell
        } else {
            if let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MenuCell, for: indexPath) as? MenuTableViewCell{
                cell.bind(model: menu[indexPath.row])
                return cell
            }
        }
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if let 
        return menu.count
    }
}

// Mark: Table View Delegate
extension SidePanelViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.selectFeed(with: menu[indexPath.row])
    }
}
