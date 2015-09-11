//
//  RequestAPI.swift
//  Test OSC server
//
//  Created by Yerdikul Nurbolat on 9/11/15.
//  Copyright © 2015 Yerdikul Nurbolat. All rights reserved.
//

import Foundation

class RequestAPI : F53OSCPacketDestination {
    enum RequestMethods : String {
        case Debug
        case Volume
        case Logvolume

        static let allValues = [Debug, Volume, Logvolume]

    }
    
    static let sharedInstance = RequestAPI()
    let SEND_HOST = "194.177.23.143"
    let SEND_PORT = 43192
    
    var OSCClient = F53OSCClient()  
    var OSCServer = F53OSCServer()
    
    // MARK: - Init
    init() {
        OSCClient.port = UInt16(SEND_PORT)
        OSCClient.host = SEND_HOST
        
        // FIXME: - Порт??
        OSCServer.port = UInt16(SEND_PORT)

        OSCServer.delegate = self
        OSCServer.startListening()
    }
    
    func sendMessage(text:String, mathodName:RequestMethods) {
        let patternAddress = "/" + mathodName.rawValue.lowercaseString
        
        let message = F53OSCMessage(addressPattern:patternAddress, arguments:[text]);
        OSCClient.sendPacket(message)
    }
    
    @objc func takeMessage(message: F53OSCMessage!) {
        
    }

}