
import UIKit

struct CustomItem {
    let image: UIImage
    let text: String
}

class TableViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var heroes: [Heroe] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        //Titulo de todo
        //title = "Heroes"
        
        navigationItem.title = "Heroes"
        
        
        
        //        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell") // identifier is unique
        
        let xib = UINib(nibName: "TableCell", bundle: nil)
        tableView.register(xib, forCellReuseIdentifier: "customTableCell")
        
        let token = LocalDataLayer.shared.getToken()
        NetworkLayer.shared.fetchHeroes(token: token){ [weak self] allHeroes, error in
            guard let self = self else { return }
            
            if let allHeroes = allHeroes {
                self.heroes = allHeroes
                LocalDataLayer.shared.save(heroes: allHeroes)
                
                // refresh tableView con new data fetched from API
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }else{
                print("Error fetching heroes: ", error?.localizedDescription ?? "")
            }
        }
    }
    
    // Delegate & DataSource methods
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return heroes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customTableCell", for: indexPath) as! TableCell
        let heroe = heroes[indexPath.row]
        cell.iconImageView.setImage(url: heroe.photo)
        cell.titleLabel.text = heroe.name
        cell.descLabel.text = heroe.description
        cell.accessoryType = .disclosureIndicator
        cell.selectionStyle = .none
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let heroe = heroes[indexPath.row]
        let detailsView = DetailsViewController()
        detailsView.heroe = heroe
        navigationController?.pushViewController(detailsView, animated: true)
    }
    
}

extension UIImageView {
    func setImage(url: String){
        guard let url = URL(string: url) else{return}
        
        downloadImage(url: url){[weak self] image in
            
            guard let self = self else {
                return
            }
            DispatchQueue.main.async {
                self.image = image
            }
            
            
        }
    }
        
        private func downloadImage(url: URL, completion: @escaping (UIImage?) -> Void){
            URLSession.shared.dataTask(with: url){ data, response, error in
                
                guard let data = data, let image = UIImage(data: data) else{
                    completion(nil)
                    return
                }
                completion(image)
                
            }.resume()
            
        }
    }

