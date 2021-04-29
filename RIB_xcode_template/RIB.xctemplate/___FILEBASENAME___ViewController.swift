//___FILEHEADER___

import Foundation
import UIKit
import RxSwift
import RxCocoa

class ___VARIABLE_productName___ViewController: UIViewController {
    
    private let disposeBag = DisposeBag()
    var interactor: ___VARIABLE_productName___Interactor!
    
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
