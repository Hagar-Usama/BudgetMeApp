//
//  AccountViewModelTests.swift
//  BudgetMeAppTests
//
//  Created by Christian Leovido on 27/03/2020.
//  Copyright © 2020 Christian Leovido. All rights reserved.
//

import XCTest
import RxSwift
import RxCocoa
import RxTest
@testable import BudgetMeApp

class AccountViewModelTests: XCTestCase {

    var accountViewModel: AccountsViewModel!

    var disposeBag: DisposeBag!
    var scheduler: TestScheduler!

    override func setUp() {

        disposeBag = DisposeBag()
        self.scheduler = TestScheduler(initialClock: 0)
    }

    override func tearDown() {
        accountViewModel = nil
    }

    func testDataSourceError() {

        accountViewModel = AccountsViewModel()

        let errorMock = scheduler.createObserver(Error.self)
        accountViewModel.errorPublisher.asObserver()
            .bind(to: errorMock)
            .disposed(by: disposeBag)

        scheduler.createColdObservable([.error(20, MockError.unknown)])
            .bind(to: accountViewModel.errorPublisher)
            .disposed(by: disposeBag)

        scheduler.start()

        XCTAssertTrue(!errorMock.events.isEmpty)

    }

    func testDataSource() {

        accountViewModel = AccountsViewModel()

        let dataSourceMock = scheduler.createObserver([STAccount].self)
        accountViewModel.dataSource
            .bind(to: dataSourceMock)
            .disposed(by: disposeBag)

        let randomAccounts = [STAccount(accountUid: "some",
                                        defaultCategory: "cat",
                                        currency: .GBP,
                                        createdAt: Date().description,
                                        balance: nil)]

        scheduler.createColdObservable([.next(15, randomAccounts)])
            .bind(to: accountViewModel.dataSource)
            .disposed(by: disposeBag)

        scheduler.start()

        XCTAssertEqual(dataSourceMock.events, [.next(0, []),
                                               .next(15, randomAccounts)])

    }

}

private enum MockError: Equatable, Error {
    case unknown
}
