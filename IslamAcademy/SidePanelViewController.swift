import UIKit

class SidePanelViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var menu = ["الرئيسية","الصوتيات","المقالات","المحاضرات"]
    
    enum CellIdentifiers {
        static let MenuCell = "MenuCell"
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
        if let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.MenuCell, for: indexPath) as? MenuTableViewCell{
            cell.title.text = menu[indexPath.row]
            return cell
        }
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu.count
    }
}

// Mark: Table View Delegate
extension SidePanelViewController: UITableViewDelegate {
    
}
