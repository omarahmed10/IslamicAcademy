
import UIKit
import FirebaseCore

class CenterViewController: UIViewController {
    
    var ref: DatabaseReference!
    
    var delegate : CenterViewControllerDelegate?
    enum CellIdentifiers {
        static let FeedCell = "FeedCell"
    }
    @IBOutlet weak var tableView: UITableView!
    
    var feedsType : FeedType = .Main
    var allFeeds = [Feed]()
    var filteredFeeds = [Feed]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        ref = Database.database().reference()

        getFeeds()
//        let f = Feed()
//        f.title = "صوت";f.describe = "صصمرمنرمرمن";f.type = .Audio;allFeeds.append(f)
//        let f1 = Feed()
//        f1.title = "كلام";f1.describe = "شمنسربشسيبش";f1.type = .Article;allFeeds.append(f1)
//        let f2 = Feed()
//        f2.title = "فيديو";f2.describe = "نشيبزنشتسزيبشسيبش";f2.type = .Video;allFeeds.append(f2)
//        filteredFeeds = allFeeds
//        tableView.reloadData()
    }
    
    @IBAction func sidePanClicked(_ sender: Any) {
        delegate?.toggleLeftPanel?()
    }
    
    func getFeeds(){
        ref.child("islamacdemy").observeSingleEvent(of: .value, with: { [weak self](snapshot) in
            // Get user value
            if let feedsDictionary = snapshot.value as? NSDictionary {
                for feed in feedsDictionary {
                    //                    feed
                }
                tableView.reloadData()
            }
            
            self?.filteredFeeds = self?.allFeeds
            self?.tableView.reloadData()
        }) { (error) in
            print(error.localizedDescription)
        }
    }
}

extension CenterViewController : SidePanelSelectionDelegate {
    func selectFeed(with type: FeedType) {
        if type == .Main {
            getFeeds()
        }else {
            filteredFeeds = allFeeds.filter{
                $0.type == type
            }
            tableView.reloadData()
        }
        delegate?.toggleLeftPanel?()
    }
    
}

extension CenterViewController : UITableViewDelegate{
    
}
extension CenterViewController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: CellIdentifiers.FeedCell, for: indexPath) as? FeedTableViewCell{
            cell.bind(model: filteredFeeds[indexPath.row])
            return cell
        }
        return UITableViewCell()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredFeeds.count
    }
}
