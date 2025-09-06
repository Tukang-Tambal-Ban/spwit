//
//  MultiPeer.swift
//  Spwit
//
//  Created by Muhammad Rifqi Syatria on 8/11/25.
//

import MultipeerConnectivity
import UIKit




class MultiPeer : UIViewController, MCSessionDelegate, MCBrowserViewControllerDelegate{
    
    var peerID : MCPeerID!
    var mcSession : MCSession!
    var mcAdvertiserAssistant : MCAdvertiserAssistant!
    
    override func viewDidLoad() {
       

        peerID = MCPeerID(displayName: UIDevice.current.name)
        mcSession = MCSession (peer: peerID, securityIdentity: nil, encryptionPreference: .required)
        mcSession.delegate = self
        
        
        
    }
    
    func sendImage(img: UIImage) {
        if mcSession.connectedPeers.count > 0 {
            if let imageData = img.pngData(){
                do{
                    try mcSession.send(imageData, toPeers:mcSession.connectedPeers, with: .reliable)
                }catch let error as NSError {
                    
                    let ac = UIAlertController(title: "send error", message: error.localizedDescription, preferredStyle: .alert)
                    present(ac, animated: true)
                }
            }
        }
    }
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state {
        case MCSessionState.connected:
            print("Connnected : \(peerID.displayName)")
            
        case MCSessionState.connecting:
            print("Connecting : \(peerID.displayName)")
            
        case MCSessionState.notConnected:
            print("not connected : \(peerID.displayName)")
        @unknown default:
            print("error lur : \(<#fatalError()#>)")
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        if let image = UIImage(data: data){
            DispatchQueue.main.async{
//
            }
        }
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        <#code#>
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        <#code#>
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: (any Error)?) {
        <#code#>
    }
    
    func browserViewControllerDidFinish(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true)
    }
    
    func browserViewControllerWasCancelled(_ browserViewController: MCBrowserViewController) {
        dismiss(animated: true)
    }
    
    
}
