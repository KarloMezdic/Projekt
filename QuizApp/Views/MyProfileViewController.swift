import UIKit
import PureLayout

class MyProfileViewController: UIViewController {
    
    private var router: AppRouterProtocol!
    
    private var gradientView: UIView!
    private var gradientLayer: CAGradientLayer!
    
    private var scrollView: UIScrollView!
    private var contentView: UIView!
    
    private var profileImageView: UIImageView!
    private var changeProfileImageButton: UIButton!
    private var currentDisplayNameLabel: UILabel!
    private var newDisplayNameLabel: UILabel!
    private var displayNameTextField: UITextField!
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
        
        scrollView = UIScrollView()
        contentView = UIView()
        
        profileImageView = UIImageView()
        profileImageView.image = UIImage(systemName: "person.circle")
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.layer.cornerRadius = 50
        profileImageView.clipsToBounds = true
        
        changeProfileImageButton = UIButton(type: .system)
        changeProfileImageButton.setTitle("Change Profile Image", for: .normal)
        changeProfileImageButton.addTarget(self, action: #selector(changeProfileImageTapped), for: .touchUpInside)
        
        currentDisplayNameLabel = UILabel()
        currentDisplayNameLabel.text = "Your Display Name:"
        
        newDisplayNameLabel = UILabel()
        newDisplayNameLabel.text = "Change Display Name:"
        
        displayNameTextField = UITextField()
        displayNameTextField.placeholder = "New Display Name"
        
        saveButton = UIButton(type: .system)
        saveButton.setTitle("Save", for: .normal)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    private func createHierarchy() {
        view.addSubview(gradientView)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(profileImageView)
        contentView.addSubview(changeProfileImageButton)
        contentView.addSubview(currentDisplayNameLabel)
        contentView.addSubview(newDisplayNameLabel)
        contentView.addSubview(displayNameTextField)
        contentView.addSubview(saveButton)
    }
    
    private func defineLayout() {
        gradientView.autoPinEdgesToSuperviewEdges()
        
        scrollView.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .top)
        scrollView.autoPinEdge(toSuperviewEdge: .top, withInset: view.safeAreaInsets.top)
        
        contentView.autoPinEdgesToSuperviewEdges()
        contentView.autoMatch(.width, to: .width, of: view)
        
        profileImageView.autoAlignAxis(toSuperviewAxis: .vertical)
        profileImageView.autoPinEdge(toSuperviewEdge: .top, withInset: 150)
        profileImageView.autoSetDimensions(to: CGSize(width: 100, height: 100))
        
        changeProfileImageButton.autoAlignAxis(.vertical, toSameAxisOf: profileImageView)
        changeProfileImageButton.autoPinEdge(.top, to: .bottom, of: profileImageView, withOffset: 10)
        
        currentDisplayNameLabel.autoAlignAxis(.vertical, toSameAxisOf: changeProfileImageButton)
        currentDisplayNameLabel.autoPinEdge(.top, to: .bottom, of: changeProfileImageButton, withOffset: 30)

        newDisplayNameLabel.autoPinEdge(.top, to: .bottom, of: currentDisplayNameLabel, withOffset: 50)
        newDisplayNameLabel.autoPinEdge(.leading, to: .leading, of: view, withOffset: 30)
        newDisplayNameLabel.autoPinEdge(toSuperviewEdge: .trailing, withInset: 100)

        displayNameTextField.autoPinEdge(.top, to: .bottom, of: newDisplayNameLabel, withOffset: 10)
        displayNameTextField.autoPinEdge(.leading, to: .leading, of: view, withOffset: 30)
        displayNameTextField.autoPinEdge(toSuperviewEdge: .trailing, withInset: 20)
        displayNameTextField.autoSetDimension(.height, toSize: 40)

        saveButton.autoPinEdge(.top, to: .bottom, of: displayNameTextField, withOffset: 30)
        saveButton.autoAlignAxis(toSuperviewAxis: .vertical)
        saveButton.autoSetDimensions(to: CGSize(width: 100, height: 50))
        
        contentView.autoPinEdge(.bottom, to: .bottom, of: saveButton, withOffset: 40)
    }
    
    private func styleViews() {
        gradientLayer.colors = [UIColor.systemBlue.cgColor, UIColor.systemMint.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.frame = view.bounds
        
        gradientView.layer.insertSublayer(gradientLayer, at: 0)
        
        changeProfileImageButton.setTitleColor(.white, for: .normal)
        
        displayNameTextField.borderStyle = .roundedRect
        
        currentDisplayNameLabel.font = UIFont.systemFont(ofSize: 24)
        currentDisplayNameLabel.font = UIFont.boldSystemFont(ofSize: 24)
        currentDisplayNameLabel.textColor = .white
        
        newDisplayNameLabel.font = UIFont.systemFont(ofSize: 18)
        newDisplayNameLabel.textColor = .white
        
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
        
        let displayName = userDefaults.string(forKey: "displayName") ?? ""
        currentDisplayNameLabel.text = "Your Display Name: \(displayName)"
    }
    
    @objc private func changeProfileImageTapped() {
        let alert = UIAlertController(title: "Error", message: "Not implemented yet.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func saveButtonTapped() {
        let defaults = UserDefaults.standard
        
        let displayName = displayNameTextField.text ?? ""
        
        defaults.set(displayName, forKey: "displayName")
        
        let alert = UIAlertController(title: "Success", message: "Your profile has been saved.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
        
        currentDisplayNameLabel.text = "Your Display Name: \(displayName)"
    }
}
