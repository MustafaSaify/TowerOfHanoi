//
//  TowerOfHanoi.swift
//  TowerOfHanoi
//
//  Created by Mustafa.saify on 19/10/2021.
//

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
    let type: RodType
    var disks: [Disk]
    
    init(name: String, type: RodType, disks: [Disk]) {
        self.name = name
        self.type = type
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

enum RodType {
    case source
    case intermediate
    case target
}

class TowerOfHanoi {
    
    private var disks: [Disk] = []
    private var rodA: Rod!
    private var rodB: Rod!
    private var rodC: Rod!
    
    init(disks: [Disk]) {
        self.disks = disks
        setUpRods()
    }
    
    private func setUpRods() {
        rodA = Rod(name: "A", type: .source, disks: disks)
        rodB = Rod(name: "B", type: .intermediate, disks: [])
        rodC = Rod(name: "C", type: .target, disks: [])
    }
    
    func solve() -> [Movement] {
        let movements = move(numberOfDisks: rodA.disks.count, from: rodA, to: rodC, intermediate: rodB)
        for movement in movements {
            print("\(movement.description)")
        }
        return movements
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
