////
////  HomePresenterTests.swift
////  HomePresenterTests
////
////  Created by Mine Rala on 8.03.2025.
////

import XCTest
@testable import CryptoVIPER

final class HomePresenterTests: XCTestCase {
    var sut: HomePresenter!
    var mockView: MockHomeView!
    var mockInteractor: MockHomeInteractor!
    var mockRouter: MockHomeRouter!

    override func setUp() {
        super.setUp()
        mockView = MockHomeView()
        mockInteractor = MockHomeInteractor()
        mockRouter = MockHomeRouter()
        sut = HomePresenter(view: mockView,
                           interactor: mockInteractor,
                           router: mockRouter)
    }

    override func tearDown() {
        sut = nil
        mockView = nil
        mockInteractor = nil
        mockRouter = nil
        super.tearDown()
    }

    func test_WhenLoadCalled_ShouldCallInteractorLoad() async {
        // Given
        let expectation = XCTestExpectation(description: "Interactor load should be called")

        // When
        sut.load()

        // Then
        await expectation.fulfill()
        wait(for: [expectation], timeout: 1)
        XCTAssertTrue(mockInteractor.isLoadCalled)
    }

    func test_WhenSelectCryptoCalled_ShouldCallInteractorSelectCrypto() {
        // Given
        let index = 1

        // When
        sut.selectCrypto(at: index)

        // Then
        XCTAssertTrue(mockInteractor.isSelectCryptoCalled)
        XCTAssertEqual(mockInteractor.selectedIndex, index)
    }

    func test_WhenHandleOutputCalled_WithSetLoading_ShouldCallViewWithSameValue() {
        // Given
        let isLoading = true

        // When
        sut.handleOutput(.setLoading(isLoading))

        // Then
        XCTAssertEqual(mockView.outputs.count, 1)
        if case .setLoading(let value) = mockView.outputs.first {
            XCTAssertEqual(value, isLoading)
        } else {
            XCTFail("Wrong output type")
        }
    }

    func test_WhenHandleOutputCalled_WithShowCryptoList_ShouldCallViewWithPresentations() {
        // Given
        let cryptos = [
            Crypto(currency: "BTC", price: "50000"),
            Crypto(currency: "ETH", price: "3000")
        ]

        // When
        sut.handleOutput(.showCryptoList(cryptos))

        // Then
        XCTAssertEqual(mockView.outputs.count, 1)
        if case .showCryptoList(let presentations) = mockView.outputs.first {
            XCTAssertEqual(presentations.count, cryptos.count)
            XCTAssertEqual(presentations[0].currency, cryptos[0].currency)
            XCTAssertEqual(presentations[0].price, cryptos[0].price)
        } else {
            XCTFail("Wrong output type")
        }
    }

    func test_WhenHandleOutputCalled_WithShowError_ShouldCallViewWithSameError() {
        // Given
        let error = "Test Error"

        // When
        sut.handleOutput(.showError(error))

        // Then
        XCTAssertEqual(mockView.outputs.count, 1)
        if case .showError(let receivedError) = mockView.outputs.first {
            XCTAssertEqual(receivedError, error)
        } else {
            XCTFail("Wrong output type")
        }
    }

    func test_WhenHandleOutputCalled_WithShowCryptoDetail_ShouldCallRouterWithSameCrypto() {
        // Given
        let crypto = Crypto(currency: "BTC", price: "50000")

        // When
        sut.handleOutput(.showCryptoDetail(crypto))

        // Then
        XCTAssertEqual(mockRouter.routes.count, 1)
        if case .detail(let receivedCrypto) = mockRouter.routes.first {
            XCTAssertEqual(receivedCrypto.currency, crypto.currency)
            XCTAssertEqual(receivedCrypto.price, crypto.price)
        } else {
            XCTFail("Wrong route type")
        }
    }
}

// MARK: - Mocks
final class MockHomeView: HomeViewProtocol {
    var outputs: [HomePresenterOutput] = []

    func handleOutput(_ output: HomePresenterOutput) {
        outputs.append(output)
    }
}

final class MockHomeInteractor: HomeInteractorProtocol {
    weak var delegate: HomeInteractorDelegate?
    var isLoadCalled = false
    var isSelectCryptoCalled = false
    var selectedIndex: Int?

    func load() async {
        isLoadCalled = true
        await Task.sleep(500_000_000)
    }

    func selectCrypto(at index: Int) {
        isSelectCryptoCalled = true
        selectedIndex = index
    }
}

final class MockHomeRouter: HomeRouterProtocol {
    var routes: [HomeRoute] = []

    func navigate(to route: HomeRoute) {
        routes.append(route)
    }
}

