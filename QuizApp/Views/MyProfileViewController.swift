import UIKit
import PureLayout

class MyProfileViewController: UIViewController {
    
    private var router: AppRouterProtocol!
    
    private var gradientView: UIView!
    private var gradientLayer: CAGradientLayer!
    
    private var scrollView: UIScrollView!
    private var contentView: UIView!
    
    private var currentUsernameLabel: UILabel!
    private var newUsernameLabel: UILabel!
    private var usernameTextField: UITextField!
    private var difficultyLabel: UILabel!
    private var difficultySegmentedControl: UISegmentedControl!
    private var saveButton: UIButton!
    
    convenience init(router: AppRouterProtocol) {
        self.init()
        self.router = router
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        createViews()
        createHierarchy()
        defineLayout()
        styleViews()
        loadUserDefaults()
                
        let backButton = UIBarButtonItem(
            title: "Home",
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
        )
        backButton.tintColor = .white
        
        navigationItem.leftBarButtonItem = backButton
    }
    
    private func createViews() {
        gradientView = UIView()
        
        gradientLayer = CAGradientLayer()
        
        currentUsernameLabel = UILabel()
        currentUsernameLabel.text = "Your username:"
        
        newUsernameLabel = UILabel()
        newUsernameLabel.text = "Change Username:"
        
        usernameTextField = UITextField()
        usernameTextField.placeholder = "New Username"
        usernameTextField.borderStyle = .roundedRect
        
        difficultyLabel = UILabel()
        difficultyLabel.text = "Choose difficulty:"
        
        difficultySegmentedControl = UISegmentedControl(items: ["Easy", "Medium", "Hard"])
        
        saveButton = UIButton(type: .system)
        saveButton.setTitle("Save", for: .normal)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    private func createHierarchy() {
        view.addSubview(gradientView)
        view.addSubview(currentUsernameLabel)
        view.addSubview(newUsernameLabel)
        view.addSubview(usernameTextField)
        view.addSubview(difficultyLabel)
        view.addSubview(difficultySegmentedControl)
        view.addSubview(saveButton)
    }
    
    private func defineLayout() {
        gradientView.autoPinEdgesToSuperviewEdges()
        
        currentUsernameLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        currentUsernameLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 150)

        newUsernameLabel.autoPinEdge(.top, to: .bottom, of: currentUsernameLabel, withOffset: 50)
        newUsernameLabel.autoPinEdge(.leading, to: .leading, of: view, withOffset: 30)
        newUsernameLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 100)

        usernameTextField.autoPinEdge(.top, to: .bottom, of: newUsernameLabel, withOffset: 10)
        usernameTextField.autoPinEdge(.leading, to: .leading, of: view, withOffset: 30)
        usernameTextField.autoPinEdge(toSuperviewEdge: .trailing, withInset: 20)
        usernameTextField.autoSetDimension(.height, toSize: 40)
        
        difficultyLabel.autoPinEdge(.top, to: .bottom, of: usernameTextField, withOffset: 30)
        difficultyLabel.autoPinEdge(.leading, to: .leading, of: view, withOffset: 30)
        difficultyLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 100)

        difficultySegmentedControl.autoPinEdge(.top, to: .bottom, of: difficultyLabel, withOffset: 10)
        difficultySegmentedControl.autoPinEdge(toSuperviewEdge: .leading, withInset: 20)
        difficultySegmentedControl.autoPinEdge(toSuperviewEdge: .trailing, withInset: 20)
        difficultySegmentedControl.autoSetDimension(.height, toSize: 40)

        saveButton.autoPinEdge(.top, to: .bottom, of: difficultySegmentedControl, withOffset: 30)
        saveButton.autoAlignAxis(toSuperviewAxis: .vertical)
        saveButton.autoSetDimensions(to: CGSize(width: 100, height: 50))
    }
    
    private func styleViews() {
        gradientLayer.colors = [UIColor.systemBlue.cgColor, UIColor.systemMint.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.frame = view.bounds
        
        gradientView.layer.insertSublayer(gradientLayer, at: 0)
        
        currentUsernameLabel.font = UIFont.systemFont(ofSize: 24)
        currentUsernameLabel.font = UIFont.boldSystemFont(ofSize: 24)
        currentUsernameLabel.textColor = .white
        
        newUsernameLabel.font = UIFont.systemFont(ofSize: 18)
        newUsernameLabel.textColor = .white
        
        difficultyLabel.textColor = .white
        
        saveButton.backgroundColor = .systemBlue
        saveButton.setTitleColor(.white, for: .normal)
        saveButton.layer.cornerRadius = 5
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = gradientView.bounds
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func loadUserDefaults() {
        let userDefaults = UserDefaults.standard
        
        let username = userDefaults.string(forKey: "username") ?? ""
        currentUsernameLabel.text = "Your username: \(username)"
        
        let difficultyLevel = userDefaults.integer(forKey: "difficultyLevel")
        difficultySegmentedControl.selectedSegmentIndex = difficultyLevel
    }
    
    @objc private func saveButtonTapped() {
        let defaults = UserDefaults.standard
        
        let username = usernameTextField.text ?? ""
        let difficultyLevel = difficultySegmentedControl.selectedSegmentIndex
        
        defaults.set(username, forKey: "username")
        defaults.set(difficultyLevel, forKey: "difficultyLevel")
        
        let alert = UIAlertController(title: "Success", message: "Your profile has been saved.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
        
        currentUsernameLabel.text = "Your username: \(username)"
    }
}
