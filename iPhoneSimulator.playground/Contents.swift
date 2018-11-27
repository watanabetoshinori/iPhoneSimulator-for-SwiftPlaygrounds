import UIKit
import PlaygroundSupport

// Sample View Controller
class ViewController: UITableViewController {
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        self.title = "Example"
    }

    // MARK: - TableView datasource
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") ?? UITableViewCell(style: .default, reuseIdentifier: "Cell")
        cell.textLabel?.text = "Row: \(indexPath.row)"
        return cell
    }

}

let viewController = ViewController()
let navigationController = UINavigationController(rootViewController: viewController)

// Run View Controller with iPhone Simulator
PlaygroundPage.current.liveView = iPhoneSimulator.liveView(with: navigationController)
