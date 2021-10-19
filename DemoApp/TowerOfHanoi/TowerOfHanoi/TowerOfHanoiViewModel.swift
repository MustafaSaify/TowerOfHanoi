//
//  TowerOfHanoiViewModel.swift
//  TowerOfHanoi
//
//  Created by Mustafa.saify on 19/10/2021.
//

import Foundation

protocol TowerOfHanoiViewModelContractor {
    func solvePuzzleWith(numberOfDisks: Int)
    
    // Bindings
    var onSourceStackUpdate: ((_ stack: [Disk]) -> ())? { get set }
    var onIntermediateStackUpdate: ((_ stack: [Disk]) -> ())? { get set }
    var onTargetStackUpdate: ((_ stack: [Disk]) -> ())? { get set }
}

class TowerOfHanoiViewModel: TowerOfHanoiViewModelContractor {
    
    private var sourceStack: [Disk] = [] {
        didSet {
            onSourceStackUpdate?(sourceStack)
        }
    }
    
    private var intermediateStack: [Disk] = [] {
        didSet {
            onIntermediateStackUpdate?(intermediateStack)
        }
    }
    
    private var targerStack: [Disk] = [] {
        didSet {
            onTargetStackUpdate?(targerStack)
        }
    }
    
    var onSourceStackUpdate: ((_ stack: [Disk]) -> ())?
    var onIntermediateStackUpdate: ((_ stack: [Disk]) -> ())?
    var onTargetStackUpdate: ((_ stack: [Disk]) -> ())?
    
    
    func solvePuzzleWith(numberOfDisks: Int) {
        let disks = getDisks(numberOfDisks: numberOfDisks)
        sourceStack = disks
        intermediateStack = []
        targerStack = []
        let toh = TowerOfHanoi(disks: disks)
        let movements = toh.solve()
        
        var count = 0
        Timer.scheduledTimer(withTimeInterval: 2.0, repeats: true) { [weak self] timer in
            if (count == movements.count) {
                timer.invalidate()
                return
            }
            let movement = movements[count]
            let fromRod = movement.fromRod
            let toRod = movement.toRod
            let disk = movement.disk
            
            if (fromRod.type == .source) {
                self?.sourceStack.removeFirst()
            } else if (fromRod.type == .intermediate) {
                self?.intermediateStack.removeFirst()
            } else if (fromRod.type == .target) {
                self?.targerStack.removeFirst()
            }
            
            if (toRod.type == .source) {
                self?.sourceStack.insert(disk, at: 0)
            } else if (toRod.type == .intermediate) {
                self?.intermediateStack.insert(disk, at: 0)
            } else if (toRod.type == .target) {
                self?.targerStack.insert(disk, at: 0)
            }
            count += 1
        }
    }
    
    private func getDisks(numberOfDisks: Int) -> [Disk] {
        var disks = [Disk]()
        for i in 1...numberOfDisks {
            disks.append(Disk(weight: i))
        }
        return disks
    }
}
