import UIKit
import PureLayout

class SettingsViewController: UIViewController {
    
    private var router: AppRouterProtocol!
    
    private var gradientView: UIView!
    private var gradientLayer: CAGradientLayer!
    
    private var scrollView: UIScrollView!
    private var contentView: UIView!
    
    private var notificationsLabel: UILabel!
    private var notificationsButton: UISwitch!
    
    private var changeThemeLabel: UILabel!
    private var changeThemeMode: UISegmentedControl!
    
    private var soundLabel: UILabel!
    private var soundButton: UISwitch!
    
    private var feedBackLabel: UILabel!
    private var starStackView: UIStackView!
    private var starButton: UIButton!
    
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
        loadSettingsFromUserDefaults()
        
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
        
        notificationsLabel = UILabel()
        notificationsLabel.text = "Turn On Notifications:"
        
        notificationsButton = UISwitch()
        
        changeThemeLabel = UILabel()
        changeThemeLabel.text = "Change Theme Mode:"
        
        changeThemeMode = UISegmentedControl(items: ["Light Mode", "Dark Mode"])
        changeThemeMode.selectedSegmentIndex = 0
        
        soundLabel = UILabel()
        soundLabel.text = "Sound:"
        
        soundButton = UISwitch()
        
        feedBackLabel = UILabel()
        feedBackLabel.text = "Feedback:"
        
        starStackView = UIStackView()

        for _ in 0..<5 {
            starButton = UIButton(type: .custom)
            starButton.setImage(UIImage(systemName: "star"), for: .normal)
            starButton.setImage(UIImage(systemName: "star.fill"), for: .selected)
            starButton.addTarget(self, action: #selector(starButtonTapped(_:)), for: .touchUpInside)
            starButton.tintColor = .blue
            starStackView.addArrangedSubview(starButton)
        }
        
        saveButton = UIButton(type: .system)
        saveButton.setTitle("Save", for: .normal)
        saveButton.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
    }
    
    private func createHierarchy() {
        view.addSubview(gradientView)
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        contentView.addSubview(notificationsLabel)
        contentView.addSubview(notificationsButton)
        contentView.addSubview(changeThemeLabel)
        contentView.addSubview(changeThemeMode)
        contentView.addSubview(soundLabel)
        contentView.addSubview(soundButton)
        contentView.addSubview(feedBackLabel)
        contentView.addSubview(starStackView)
        contentView.addSubview(saveButton)
    }
    
    private func defineLayout() {
        gradientView.autoPinEdgesToSuperviewEdges()
        
        scrollView.autoPinEdgesToSuperviewEdges(with: .zero, excludingEdge: .top)
        scrollView.autoPinEdge(toSuperviewEdge: .top, withInset: view.safeAreaInsets.top)
        
        contentView.autoPinEdgesToSuperviewEdges()
        contentView.autoMatch(.width, to: .width, of: view)
        
        notificationsLabel.autoPinEdge(toSuperviewEdge: .top, withInset: 150)
        notificationsLabel.autoPinEdge(.leading, to: .leading, of: view, withOffset: 30)
        
        notificationsButton.autoAlignAxis(.horizontal, toSameAxisOf: notificationsLabel)
        notificationsButton.autoPinEdge(.leading, to: .trailing, of: notificationsLabel, withOffset: 10)
        
        changeThemeLabel.autoPinEdge(.top, to: .bottom, of: notificationsLabel, withOffset: 30)
        changeThemeLabel.autoPinEdge(.leading, to: .leading, of: view, withOffset: 30)
        
        changeThemeMode.autoAlignAxis(.horizontal, toSameAxisOf: changeThemeLabel)
        changeThemeMode.autoPinEdge(.leading, to: .trailing, of: changeThemeLabel, withOffset: 10)
        
        soundLabel.autoPinEdge(.top, to: .bottom, of: changeThemeMode, withOffset: 30)
        soundLabel.autoPinEdge(.leading, to: .leading, of: view, withOffset: 30)
        
        soundButton.autoAlignAxis(.horizontal, toSameAxisOf: soundLabel)
        soundButton.autoPinEdge(.leading, to: .trailing, of: soundLabel, withOffset: 10)
        
        feedBackLabel.autoPinEdge(.top, to: .bottom, of: soundButton, withOffset: 30)
        feedBackLabel.autoPinEdge(.leading, to: .leading, of: view, withOffset: 30)
        
        starStackView.autoAlignAxis(.horizontal, toSameAxisOf: feedBackLabel)
        starStackView.autoPinEdge(.leading, to: .trailing, of: feedBackLabel, withOffset: 10)
        
        saveButton.autoPinEdge(.top, to: .bottom, of: starStackView, withOffset: 50)
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
        
        notificationsLabel.textColor = .white
        
        notificationsButton.onTintColor = .blue
        notificationsButton.thumbTintColor = .white
        
        changeThemeLabel.textColor = .white
        
        soundLabel.textColor = .white
        
        soundButton.onTintColor = .blue
        soundButton.thumbTintColor = .white
        
        feedBackLabel.textColor = .white
        
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
    
    @objc private func saveButtonTapped() {
        let alert = UIAlertController(title: "Success", message: "Your settings have been saved.", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    @objc private func starButtonTapped(_ sender: UIButton) {
        guard let index = starStackView.arrangedSubviews.firstIndex(of: sender) else { return }
        
        for i in 0..<starStackView.arrangedSubviews.count {
            if let starButton = starStackView.arrangedSubviews[i] as? UIButton {
                starButton.isSelected = (i <= index)
                starButton.tintColor = (i <= index) ? .purple : .blue
            }
        }
        saveSettingsToUserDefaults()
    }

    private func saveSettingsToUserDefaults() {
        let defaults = UserDefaults.standard
        
        defaults.set(notificationsButton.isOn, forKey: "notificationsEnabled")
        
        defaults.set(changeThemeMode.selectedSegmentIndex, forKey: "selectedThemeIndex")
        
        defaults.set(soundButton.isOn, forKey: "soundEnabled")
        
        var selectedStars = 0
        for i in 0..<starStackView.arrangedSubviews.count {
            if let starButton = starStackView.arrangedSubviews[i] as? UIButton, starButton.isSelected {
                selectedStars += 1
            }
        }
        defaults.set(selectedStars, forKey: "selectedStars")
    }
    
    private func loadSettingsFromUserDefaults() {
        let defaults = UserDefaults.standard
        
        let notificationsEnabled = defaults.bool(forKey: "notificationsEnabled")
        notificationsButton.isOn = notificationsEnabled
        
        let selectedThemeIndex = defaults.integer(forKey: "selectedThemeIndex")
        changeThemeMode.selectedSegmentIndex = selectedThemeIndex
        
        let soundEnabled = defaults.bool(forKey: "soundEnabled")
        soundButton.isOn = soundEnabled
        
        let selectedStarsCount = defaults.integer(forKey: "selectedStars")
        for i in 0..<starStackView.arrangedSubviews.count {
            if let starButton = starStackView.arrangedSubviews[i] as? UIButton {
                starButton.isSelected = (i < selectedStarsCount)
                starButton.tintColor = (i < selectedStarsCount) ? .purple : .blue
            }
        }
    }
}
