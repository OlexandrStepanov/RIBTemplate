//
//  HomeViewController.swift
//  RIBTemplate
//
//  Created by Oleksandr Stepanov on 29.04.2021.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class HomeViewController: UIViewController {
    
    @IBOutlet private weak var homeLabel: UILabel!

    private let disposeBag = DisposeBag()
	var interactor: HomeInteractor!

	override func viewDidLoad() {
		super.viewDidLoad()

	}
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        interactor.viewPresented.onNext(())
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        interactor.viewDismissed.onNext(())
    }
}
