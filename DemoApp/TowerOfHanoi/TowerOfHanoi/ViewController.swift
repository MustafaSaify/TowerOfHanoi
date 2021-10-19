import UIKit

class TowerOfHanoiViewController : UIViewController {
    
    @IBOutlet weak var leftStack: UIStackView!
    @IBOutlet weak var middleStack: UIStackView!
    @IBOutlet weak var rightStack: UIStackView!
    
    @IBOutlet weak var disksCountInputField: UITextField!
    
    var viewModel: TowerOfHanoiViewModelContractor = TowerOfHanoiViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bindViewModel()
    }
    
    private func bindViewModel() {
        viewModel.onSourceStackUpdate = { (disks) in
            self.layoutStack(stack: self.leftStack, items: disks)
        }
        
        viewModel.onIntermediateStackUpdate = { (disks) in
            self.layoutStack(stack: self.middleStack, items: disks)
        }
        
        viewModel.onTargetStackUpdate = { (disks) in
            self.layoutStack(stack: self.rightStack, items: disks)
        }
    }
    
    @IBAction func startPuzzle() {
        let numberOfDisks = Int(disksCountInputField.text ?? "") ?? 3
        viewModel.solvePuzzleWith(numberOfDisks: numberOfDisks)
    }
    
    private func layoutStack(stack: UIStackView, items: [Disk]) {
        stack.removeAllArrangedSubviews()
        for item in items {
            let diskView: DiskView = .fromNib()
            diskView.frame = CGRect.init(origin: .zero, size: CGSize(width: stack.frame.width, height: 20.0))
            diskView.translatesAutoresizingMaskIntoConstraints = true
            diskView.configureWith(disk: item)
            stack.addArrangedSubview(diskView)
        }
    }
}





