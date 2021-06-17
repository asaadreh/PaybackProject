

import XCTest
@testable import Payback_Project

class ViewModelTests: XCTestCase {
    
    let mockAPIFailure = MockFeedServiceAPI(serviceFlow: .failure, nextHandler: nil)
    let mockCacheFailure = MockCacheService(serviceFlow: .failure, nextHandler: nil)
    let mockPersistenceLayerFailure = MockPersistenceLayerService(serviceFlow: .failure, nextHandler: nil)
    
    let mockAPISuccess = MockFeedServiceAPI(serviceFlow: .success, nextHandler: nil)
    let mockCacheSuccess = MockCacheService(serviceFlow: .success, nextHandler: nil)
    let mockPersistenceLayerSuccess = MockPersistenceLayerService(serviceFlow: .success, nextHandler: nil)
    
    var mockChain : FeedServiceProtocol!
    var c : MainCoordinator!
    var vm : FeedViewModel!

    override func setUpWithError() throws {
        mockChain = FeedServiceChain.buildChain(services: [mockAPIFailure,
                                                   mockCacheFailure,
                                                   mockPersistenceLayerSuccess])
       
        c = MainCoordinator(navigationController: UINavigationController())
        vm = FeedViewModel(coordinator: c,service: mockChain)
    }
    
    func testFeedViewModelOrder() {
        
        for i in 0..<vm.items.count-1 {
            let first = vm.items[i].score
            let second = vm.items[i+1].score
            
            XCTAssertGreaterThan(first, second)
        }
    }
    
    func testFeedImageItemViewModel() {
        
        let imageItems : [FeedViewModelImageItem] = vm.items.compactMap({$0 as? FeedViewModelImageItem})
        
        XCTAssertEqual(imageItems.count, 3)
    }
    
    func testFeedVideoItemViewModel() {
        
        let videoItems : [FeedViewModelVideoItem] = vm.items.compactMap({$0 as? FeedViewModelVideoItem})
        
        XCTAssertEqual(videoItems.count, 1)
    }
    
    func testFeedShoppingListItemViewModel() {
        
        
        let shoppingItems : [FeedViewModelShoppingListItem] = vm.items.compactMap({$0 as? FeedViewModelShoppingListItem})
        
        XCTAssertNotEqual(shoppingItems.count, 3)
        XCTAssertEqual(shoppingItems.count, 1)
    }
    
    func testFeedWebsiteItemViewModel() {
       
        
        let websiteItems : [FeedViewModelWebsiteItem] = vm.items.compactMap({$0 as? FeedViewModelWebsiteItem})
        
        XCTAssertNotEqual(websiteItems.count, 1)
        XCTAssertEqual(websiteItems.count, 3)
    }
    
    
    func testImageItemSelection() {
        
        
        let imageItems : [FeedViewModelImageItem] = vm.items.compactMap({$0 as? FeedViewModelImageItem})
        
        for item in imageItems {
            item.selected(item)
            XCTAssertEqual(c.navigationController.viewControllers.count, 1)
        }
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
