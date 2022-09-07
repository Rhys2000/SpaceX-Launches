
import Foundation

struct SupportVessel: Codable {
    let supportVesselName: String
    let supportVesselFormerNames: [String]
    let internationalMaritimeOrganizationNumber: Int
    let supportVesselOwner: String
    let ownerWebsite: String
    let supportVesselOperator: String
    let operatorWebsite: String
    let supportVesselType: String
    let countryOfRegistration: String
    let portOfCalling: String
    let portOfCallingLatitude: Double
    let portOfCallingLongitude: Double
    let yearBuilt: Int
    let hullLength: Double
    let hullWidth: Double
    let yearJoinedSupportFleet: Int
    let yearLeftSupportFleet: Int
    let isActive: String
    let photographerCredit: String
    let marineFleetLink: String
}

public class SupportVesselLoader {
    @Published var allSupportVessels = [SupportVessel]()
    
    init() {
        if let fileLocation = Bundle.main.url(forResource: "supportvessel", withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileLocation)
                let jsonDecoder = JSONDecoder()
                let dataFromJson = try jsonDecoder.decode([SupportVessel].self, from: data)
                
                self.allSupportVessels = dataFromJson
                
            } catch {
                print(error)
            }
        }
    }
}
