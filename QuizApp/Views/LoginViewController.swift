import Foundation
import UIKit
import PureLayout

class LoginViewController: UIViewController {
    
    private var router: AppRouterProtocol!
    
    convenience init(router: AppRouterProtocol) {
        self.init()
        self.router = router
    }
    
    private var gradientView: UIView!
    private var gradientLayer: CAGradientLayer!
    
    private var scrollView: UIScrollView!
    private var contentView: UIView!
    
    private var welcomeLabel: UILabel!
    private var username: UITextField!
    private var password: UITextField!
    private var loginButton: UIButton!
    private var signupButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLoginUI()
    }
    
    private func setupLoginUI() {
        createViews()
        createHierarchy()
        styleViews()
        defineLayout()
    }
    
    private func createViews() {
        gradientView = UIView()
        
        gradientLayer = CAGradientLayer()
        
        scrollView = UIScrollView()
        
        contentView = UIView()
        
        welcomeLabel = UILabel()
        welcomeLabel.text = "Welcome to QuizApp"
        
        username = UITextField()
        username.placeholder = "Username"
        
        password = UITextField()
        password.placeholder = "Password"
        
        loginButton = UIButton(type: .system)
        loginButton.setTitle("Login", for: .normal)
        
        signupButton = UIButton()
        signupButton.setTitle("Sign up", for: .normal)
     
    }
    
    private func createHierarchy() {
        view.addSubview(gradientView)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(welcomeLabel)
        contentView.addSubview(username)
        contentView.addSubview(password)
        contentView.addSubview(loginButton)
        contentView.addSubview(signupButton)
        
    }
    
    private func styleViews() {
        gradientLayer.colors = [UIColor.systemBlue.cgColor, UIColor.systemMint.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
        gradientLayer.frame = view.bounds
        
        gradientView.layer.insertSublayer(gradientLayer, at: 0)
        
        welcomeLabel.textColor = .white
        welcomeLabel.font = UIFont.boldSystemFont(ofSize: 36)
        
        username.borderStyle = .roundedRect
        
        password.borderStyle = .roundedRect
        password.isSecureTextEntry = true
        
        loginButton.setTitleColor(.white, for: .normal)
        loginButton.backgroundColor = .systemBlue
        loginButton.layer.borderWidth = 2
        loginButton.layer.borderColor = UIColor.white.cgColor
        loginButton.layer.cornerRadius = 10
        loginButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        
        signupButton.setTitleColor(.white, for: .normal)
        signupButton.backgroundColor = .systemPurple
        signupButton.layer.borderWidth = 2
        signupButton.layer.borderColor = UIColor.white.cgColor
        signupButton.layer.cornerRadius = 10
        signupButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        
    }
    
    private func defineLayout() {
        gradientView.autoPinEdgesToSuperviewEdges()
                
        scrollView.autoPinEdgesToSuperviewEdges()
        contentView.autoPinEdgesToSuperviewEdges()
        contentView.autoMatch(.width, to: .width, of: view)
        
        welcomeLabel.autoAlignAxis(toSuperviewAxis: .vertical)
        welcomeLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 100)
        
        username.autoPinEdge(.top, to: .bottom, of: welcomeLabel, withOffset: 50)
        username.autoPinEdge(.leading, to: .leading, of: view, withOffset: 100)
        username.autoPinEdge(toSuperviewEdge: .trailing, withInset: 100)
        
        password.autoPinEdge(.top, to: .bottom, of: username, withOffset: 20)
        password.autoPinEdge(.leading, to: .leading, of: view, withOffset: 100)
        password.autoPinEdge(toSuperviewEdge: .trailing, withInset: 100)

        loginButton.autoPinEdge(.top, to: .bottom, of: password, withOffset: 40)
        loginButton.autoPinEdge(.leading, to: .leading, of: view, withOffset: 150)
        loginButton.autoPinEdge(toSuperviewEdge: .trailing, withInset: 150)
        
        signupButton.autoPinEdge(.top, to: .bottom, of: loginButton, withOffset: 20)
        signupButton.autoPinEdge(.leading, to: .leading, of: view, withOffset: 150)
        signupButton.autoPinEdge(toSuperviewEdge: .trailing, withInset: 150)
        
        contentView.autoPinEdge(.bottom, to: .bottom, of: signupButton, withOffset: 40)
        
        loginButton.addTarget(self, action: #selector(loginButtonTapped), for: .touchUpInside)
        signupButton.addTarget(self, action: #selector(signupButtonTapped), for: .touchUpInside)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        gradientLayer.frame = gradientView.bounds
    }
    
    @objc private func loginButtonTapped() {
        guard let username = username.text, !username.isEmpty,
            let password = password.text, !password.isEmpty else {
            showAlert(message: "Please enter both username and password.")
            return
        }
        
        UserDefaults.standard.set(username, forKey: "username")
        
        router.navigateToHomeScreen()
        
        func showAlert(message: String) {
            let alert = UIAlertController(title: "Login", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alert, animated: true, completion: nil)
        }
    }
    
    @objc private func signupButtonTapped() {
        //otvori se novi ekran, i onda nutra ima da upise mail, username i dva puta lozinku
        //ako lozinka nije 2 put ista, onda mora ponoviti
        //na kraju ima button kao tjt
    }
}
