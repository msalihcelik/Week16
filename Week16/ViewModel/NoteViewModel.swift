//
//  NoteViewModel.swift
//  Week16
//
//  Created by Mehmet Salih ÇELİK on 30.01.2022.
//

import Foundation

struct NoteViewModel {
    
    var noteList: [NoteModel]
    
    func 
    
    func HomeVM() -> HomeViewModel {
        return HomeViewModel(home: homeList[0])
    }
    
    func FirstVM() -> FirstViewModel {
        return FirstViewModel(home: homeList[1])
    }
    
    func SecondVM() -> SecondViewModel {
        return SecondViewModel(home: homeList[2])
    }
    
    func ThirdVM() -> ThirdViewModel {
        return ThirdViewModel(home: homeList[3])
    }
    
    func FourthVM() -> FourthViewModel {
        return FourthViewModel(home: homeList[4])
    }
    
    func KitchenVM() -> KitchenViewModel {
        return KitchenViewModel(home: homeList[5])
    }
    
}
