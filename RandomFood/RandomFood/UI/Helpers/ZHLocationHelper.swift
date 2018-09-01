//
//  ZHLocationHelper.swift
//  RandomFood
//
//  Created by DarrenW on 2018/8/31.
//  Copyright © 2018年 Darren. All rights reserved.
//

import RxSwift

struct ZHLocation {
    
    var latitude: Double
    var longitude: Double
    var placeName: String
    var city: String
}

enum ZHLocationError: Error {
    case locationError
    case reGeocodeError
}


class ZHLocationHelper: NSObject {
    
    static let share = ZHLocationHelper()
    
    lazy var locationManager: AMapLocationManager = {
        let manager = AMapLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        manager.locationTimeout = 2
        manager.reGeocodeTimeout = 2
        return manager
    }()
    
    lazy var search: AMapSearchAPI = {
        let searchAPI = AMapSearchAPI()
        searchAPI?.delegate = self
        return searchAPI!
    }()
    
    var searchObser: AnyObserver<[ZHDiningRoom]>?
    
    let disposeBag = DisposeBag()
    
    private override init() {
        super.init()
    }
    
    func searchAround() -> Observable<[ZHDiningRoom]> {
        getLocation().subscribe(onNext: {[weak self] location in
            self?.searchAround(location: location)
        }, onError: { error in
            self.searchObser?.onError(error)
        }).disposed(by: disposeBag)
        
        return Observable<[ZHDiningRoom]>.create({ (observer) -> Disposable in
            self.searchObser = observer
            return Disposables.create()
        })
    }
    
    private func getLocation() -> Observable<ZHLocation> {
        return Observable<ZHLocation>.create({ (observer) -> Disposable in
            self.locationManager.requestLocation(withReGeocode: true, completionBlock: {(location: CLLocation?, reGeocode: AMapLocationReGeocode?, error: Error?) in
                guard error == nil else {
                    if location != nil {
                        observer.onError(ZHLocationError.reGeocodeError)
                    } else {
                        observer.onError(ZHLocationError.locationError)
                    }
                    return
                }
                
                if let location = location,
                    let reGeocode = reGeocode {
                    let loc = ZHLocation(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude, placeName: reGeocode.formattedAddress, city: reGeocode.city)
                    observer.onNext(loc)
                }
                
                observer.onCompleted()
            })
            return Disposables.create()
        })
    }
    
    private func searchAround(location: ZHLocation) {
        let request = AMapPOIAroundSearchRequest()
        request.keywords = "餐厅|快餐|食品|吃饭"
        request.requireExtension = true
        request.city = location.city
        request.sortrule = 0
        request.offset = 50
        request.radius = 2000
        request.requireSubPOIs = true
        request.location = AMapGeoPoint.location(withLatitude: CGFloat(location.latitude), longitude: CGFloat(location.longitude))
        search.aMapPOIAroundSearch(request)
    }
    
}

extension ZHLocationHelper: AMapSearchDelegate {
    func onPOISearchDone(_ request: AMapPOISearchBaseRequest!, response: AMapPOISearchResponse!) {
        if response.count == 0 {
            return
        }
        let pois = response.pois
        var drooms:Array<ZHDiningRoom> = []
        pois?.forEach({ poi in
            let diningroom = ZHDiningRoom(poi: poi)
            drooms.append(diningroom)
        })
        searchObser?.onNext(drooms)
        searchObser?.onCompleted()
        searchObser = nil
    }

}

