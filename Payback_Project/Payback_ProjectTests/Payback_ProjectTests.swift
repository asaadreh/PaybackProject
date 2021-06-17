

import XCTest

@testable import Payback_Project

class Payback_ProjectTests: XCTestCase {
    
    var mockAPIFailure : MockFeedServiceAPI!
    var mockCacheFailure : MockCacheService!
    var mockPersistenceLayerFailure : MockPersistenceLayerService!
    
    var mockAPISuccess : MockFeedServiceAPI!
    var mockCacheSuccess : MockCacheService!
    var mockPersistenceLayerSuccess : MockPersistenceLayerService!
    
    var mockChain : FeedServiceProtocol!
    var c : MainCoordinator!
    var vm : FeedViewModel!
    var mockChainFailure : FeedServiceProtocol!
    
    
    override func setUpWithError() throws {
        
         mockAPIFailure = MockFeedServiceAPI(serviceFlow: .failure, nextHandler: nil)
         mockCacheFailure = MockCacheService(serviceFlow: .failure, nextHandler: nil)
         mockPersistenceLayerFailure = MockPersistenceLayerService(serviceFlow: .failure, nextHandler: nil)
         mockAPISuccess = MockFeedServiceAPI(serviceFlow: .success, nextHandler: nil)
         mockCacheSuccess = MockCacheService(serviceFlow: .success, nextHandler: nil)
         mockPersistenceLayerSuccess = MockPersistenceLayerService(serviceFlow: .success, nextHandler: nil)
        
        mockChain = FeedServiceChain.buildChain(services: [mockAPIFailure,
                                                   mockCacheFailure,
                                                   mockPersistenceLayerSuccess])
        
        
        
        mockChainFailure = FeedServiceChain.buildChain(services: [mockAPIFailure,
                                                   mockCacheFailure,
                                                   mockPersistenceLayerFailure])
        
        
        
       
        c = MainCoordinator(navigationController: UINavigationController())
        vm = FeedViewModel(coordinator: c,service: mockChain)
    }
    
    func testServiceChainFailure() {

        mockChain.fetchFeed { res in
            switch res {
            case .failure(let error):
                XCTAssertEqual(error, FeedError.EndOfChain)
            case .success(let feed):
                XCTAssertNil(feed)
            }
        }
    }
    
    func testServiceChainSuccess() {

        
        let service = MockFeedServiceChain.mainChain()
        
        //let expectation = expectation(description: "mockChain FeedService does stuff and runs the callback closure")
        
        service.fetchFeed { res in
            switch res {
            case .failure(let error):
                XCTFail("expectation error: \(error)")
            case .success(let feed):
                
                XCTAssertNotNil(feed)
                
                //expectation.fulfill()
            }
        }
    }
    
    func testCoordinators() {
        
        let c = MainCoordinator(navigationController: UINavigationController())

        XCTAssertEqual(c.navigationController.viewControllers.count, 0)
    }
    
    func testDateOneDayAgoTrue() {
        let date = Date(timeIntervalSinceNow: -86401)
        let test = date.isOneDayAgo()
        
        XCTAssertTrue(test)
        
    }
    
    
    func testDateOneDayAgoFalse() {
        let date = Date()
        let test = date.isOneDayAgo()
        
        XCTAssertFalse(test)
        
    }
   


    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
