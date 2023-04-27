//
//  ViewController.swift
//  ReactorKitPractice
//
//  Created by 유지호 on 2023/04/27.
//

import UIKit
import RxCocoa
import ReactorKit
import Then
import SnapKit

final class ViewController: UIViewController, View {
    
    typealias Reactor = ViewReactor
    
    var disposeBag = DisposeBag()

    private var plusButton = UIButton().then {
        $0.setTitle("+", for: .normal)
        $0.setTitleColor(.systemBlue, for: .normal)
        $0.tintColor = .systemBlue
    }
    
    private var minusButton = UIButton().then {
        $0.setTitle("-", for: .normal)
        $0.setTitleColor(.systemBlue, for: .normal)
    }
    
    private var stateLabel = UILabel().then {
        $0.textColor = .black
        $0.textAlignment = .center
    }
    
    private var nextButton = UIButton().then {
        $0.setTitle("다음", for: .normal)
        $0.backgroundColor = .systemBlue
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        initConstraints()
    }

    
    func bind(reactor: ViewReactor) {
        bindAction(reactor)
        bindState(reactor)
    }
    
    private func bindAction(_ reactor: ViewReactor) {
        plusButton.rx.tap
            .map { Reactor.Action.increase }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        minusButton.rx.tap
            .map { Reactor.Action.decrease }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
        
        nextButton.rx.tap
            .map { Reactor.Action.next }
            .bind(to: reactor.action)
            .disposed(by: disposeBag)
    }
    
    private func bindState(_ reactor: ViewReactor) {
        reactor.state
            .map { String($0.value) }
            .distinctUntilChanged()
            .bind(to: stateLabel.rx.text)
            .disposed(by: disposeBag)
        
        
    }
    
    private func initConstraints() {
        [plusButton, minusButton, stateLabel, nextButton].forEach {
            view.addSubview($0)
        }
        
        stateLabel.snp.makeConstraints {
            $0.width.equalTo(40)
            $0.height.equalTo(20)
            $0.center.equalToSuperview()
        }
        
        plusButton.snp.makeConstraints {
            $0.left.equalTo(stateLabel.snp.right)
            $0.centerY.equalTo(stateLabel)
        }
        
        minusButton.snp.makeConstraints {
            $0.right.equalTo(stateLabel.snp.left)
            $0.centerY.equalTo(stateLabel)
        }
        
        nextButton.snp.makeConstraints {
            $0.left.right.bottom.equalToSuperview()
            $0.height.equalTo(56)
        }
    }
    
}

