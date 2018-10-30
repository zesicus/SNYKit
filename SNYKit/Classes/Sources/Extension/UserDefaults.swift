//
//  UserDefaults.swift
//  Alamofire
//
//  Created by Sunny on 2018/10/15.
//

import Foundation

// 例
//class SearchHistoryModel: NSObject, NSCoding {
//
//    struct PropertyKey {
//        static let timeKey = "timeKey"
//        static let jobsKey = "jobsKey"
//        static let salaryKey = "salaryKey"
//        static let countriesKey = "countriesKey"
//        static let provincesKey = "provincesKey"
//        static let totalNumKey = "totalNumKey"
//    }
//
//    var time: String
//    var jobs: [String]
//    var salary: [String]
//    var countries: [String]
//    var provinces: [String]
//    var totalNum: Int
//
//    init(time: String, jobs: [String], salary: [String], countries: [String], provinces: [String], totalNum: Int) {
//        self.time = time
//        self.jobs = jobs
//        self.salary = salary
//        self.countries = countries
//        self.provinces = provinces
//        self.totalNum = totalNum
//    }
//
//    func encode(with aCoder: NSCoder) {
//        aCoder.encode(time, forKey: PropertyKey.timeKey)
//        aCoder.encode(jobs, forKey: PropertyKey.jobsKey)
//        aCoder.encode(salary, forKey: PropertyKey.salaryKey)
//        aCoder.encode(countries, forKey: PropertyKey.countriesKey)
//        aCoder.encode(provinces, forKey: PropertyKey.provincesKey)
//        aCoder.encode(totalNum, forKey: PropertyKey.totalNumKey)
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        time = aDecoder.decodeObject(forKey: PropertyKey.timeKey) as! String
//        jobs = aDecoder.decodeObject(forKey: PropertyKey.jobsKey) as! [String]
//        salary = aDecoder.decodeObject(forKey: PropertyKey.salaryKey) as! [String]
//        countries = aDecoder.decodeObject(forKey: PropertyKey.countriesKey) as! [String]
//        provinces = aDecoder.decodeObject(forKey: PropertyKey.provincesKey) as! [String]
//        totalNum = aDecoder.decodeObject(forKey: PropertyKey.totalNumKey) as! Int
//    }
//
//}

public extension UserDefaults {
    
    //存复杂对象
    public func saveCustomObject(customObject object: NSCoding, key: String) {
        let encodedObject = NSKeyedArchiver.archivedData(withRootObject: object)
        self.set(encodedObject, forKey: key)
    }
    
    //取复杂对象
    public func getCustomObject(forKey key: String) -> AnyObject? {
        let decodedObject = self.object(forKey: key) as? NSData
        
        if let decoded = decodedObject {
            let object = NSKeyedUnarchiver.unarchiveObject(with: decoded as Data)
            return object as AnyObject
        }
        
        return nil
    }
    
}
