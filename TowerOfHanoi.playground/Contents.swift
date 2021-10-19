// Algo
func towerOfHanoi(numberOfDisks: Int) -> Int {
    if (numberOfDisks == 1) {
        return 1
    }
    return towerOfHanoi(numberOfDisks: numberOfDisks - 1) + 1 + towerOfHanoi(numberOfDisks: numberOfDisks - 1)
}
towerOfHanoi(numberOfDisks: 4)


class Disk {
    let weight: Int
    var name: String {
        return "Disk \(weight)"
    }
    
    init(weight: Int) {
        self.weight = weight
    }
}

class Rod {
    let name: String
    var disks: [Disk]
    
    init(name: String, disks: [Disk]) {
        self.name = name
        self.disks = disks
    }
}

class Movement {
    var fromRod: Rod
    var toRod: Rod
    var disk: Disk
    
    init(fromRod: Rod, toRod: Rod, disk: Disk) {
        self.fromRod = fromRod
        self.toRod = toRod
        self.disk = disk
    }
    
    var description: String {
        return "Take \(disk.name) from \(fromRod.name) to \(toRod.name)"
    }
}

class TowerOfHanoi {
    
    let numberOfDisks: Int
    private var disks: [Disk] = []
    
    private var rodA: Rod!
    private var rodB: Rod!
    private var rodC: Rod!
    
    init(numberOfDisks: Int) {
        self.numberOfDisks = numberOfDisks
        setUpDisks()
        setUpRods()
    }
    
    private func setUpDisks() {
        for i in 1...numberOfDisks {
            disks.append(Disk(weight: i))
        }
    }
    
    private func setUpRods() {
        rodA = Rod(name: "A", disks: disks)
        rodB = Rod(name: "B", disks: [])
        rodC = Rod(name: "C", disks: [])
    }
    
    func solve() {
        let movements = move(numberOfDisks: rodA.disks.count, from: rodA, to: rodC, intermediate: rodB)
        for movement in movements {
            print("\(movement.description)")
        }
    }
    
    private func move(numberOfDisks: Int, from fromRod: Rod, to toRod: Rod, intermediate intrmediateRod: Rod) -> [Movement] {
        var movements = [Movement]()
        guard numberOfDisks >= 1 else {
            return movements
        }
        // 1. #OfDisks = 4, from: A, to: C, int: B, movements: []
        //      - #OfDisks = 3, from: A, to: B, int: C, movements: []
        //      - #OfDisks = 2, from: A, to: C, int: B, movements: []
        //      - #OfDisks = 1, from: A, to: B, int: C, movements: []
        //      - Record movement A to B, movements: [A to B]
        //      - Record movement A to C, movements: [A to B, A to C]
        //      - #OfDisks = 1, from: B, to: C, int: A, movements: [A to B, A to C]
        //      - Record movement B to C, movements: [A to B, A to C, B to C]
        //      - Record movement A to B, movements: [A to B, A to C, B to C, A to B]
        //      - #OfDisks = 2, from: C, to: B, int: A, movements: [A to B, A to C, B to C, A to B]
        //      - #OfDisks = 1, from: C, to: A, int: B, movements: [A to B, A to C, B to C, A to B]
        //      - Record movement C to A, movements: [A to B, A to C, B to C, A to B, C to A]
        //      - Record movement C to B, movements: [A to B, A to C, B to C, A to B, C to A, C to B]
        //      - #OfDisks = 1, from: C, to: A, int: B, movements: [A to B, A to C, B to C, A to B, C to B]
        
        // Recursively move n-1 disks from source rod to intermediate rod.
        movements += move(numberOfDisks: numberOfDisks - 1, from: fromRod, to: intrmediateRod, intermediate: toRod)
        
        // Move the 'nth' disk (which is on top now) from source rod to target rod.
        let diskToMove = fromRod.disks.first!
        fromRod.disks.removeFirst()
        toRod.disks.insert(diskToMove, at: 0)
        movements.append(Movement(fromRod: fromRod, toRod: toRod, disk: diskToMove))
        
        // Move the n-1 disks from intermediate rod to target rod.
        movements += move(numberOfDisks: numberOfDisks - 1, from: intrmediateRod, to: toRod, intermediate: fromRod)
        return movements
    }
}

let towerOfHonai = TowerOfHanoi(numberOfDisks: 3)
towerOfHonai.solve()



//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        let label = UILabel()
        label.frame = CGRect(x: 150, y: 200, width: 200, height: 20)
        label.text = "Hello World!"
        label.textColor = .black
        
        view.addSubview(label)
        self.view = view
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
