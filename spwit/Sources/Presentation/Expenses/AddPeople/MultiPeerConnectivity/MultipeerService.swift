import MultipeerConnectivity
import UIKit

protocol MultipeerServiceDelegate: AnyObject {
    func didReceivePeerUser(_ user: PeerUser)
}

final class MultipeerService: NSObject {
    private let serviceType = "splitbill"
    private let myPeerId = MCPeerID(displayName: UIDevice.current.name)
    private let session: MCSession
    private let advertiser: MCNearbyServiceAdvertiser
    private let browser: MCNearbyServiceBrowser

    weak var delegate: MultipeerServiceDelegate?

    override init() {
        session = MCSession(peer: myPeerId, securityIdentity: nil, encryptionPreference: .required)
        advertiser = MCNearbyServiceAdvertiser(peer: myPeerId, discoveryInfo: nil, serviceType: serviceType)
        browser = MCNearbyServiceBrowser(peer: myPeerId, serviceType: serviceType)
        super.init()

        session.delegate = self
        advertiser.delegate = self
        browser.delegate = self

        advertiser.startAdvertisingPeer()
        browser.startBrowsingForPeers()
    }

    func send(peerUser: PeerUser) {
        guard !session.connectedPeers.isEmpty else { return }
        if let data = try? JSONEncoder().encode(peerUser) {
            try? session.send(data, toPeers: session.connectedPeers, with: .reliable)
        }
    }
}

extension MultipeerService: MCSessionDelegate, MCNearbyServiceAdvertiserDelegate, MCNearbyServiceBrowserDelegate {
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        print("Peer \(peerID.displayName) changed state: \(state.rawValue)")
    }

    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        guard let user = try? JSONDecoder().decode(PeerUser.self, from: data) else { return }
        DispatchQueue.main.async {
            self.delegate?.didReceivePeerUser(user)
        }
    }

    // Not used but required
    func session(_: MCSession, didReceive _: InputStream, withName _: String, fromPeer _: MCPeerID) {}
    func session(_: MCSession, didStartReceivingResourceWithName _: String, fromPeer _: MCPeerID, with _: Progress) {}
    func session(_: MCSession, didFinishReceivingResourceWithName _: String, fromPeer _: MCPeerID, at _: URL?, withError _: Error?) {}
    func advertiser(_: MCNearbyServiceAdvertiser, didNotStartAdvertisingPeer _: Error) {}
    func browser(_: MCNearbyServiceBrowser, didNotStartBrowsingForPeers _: Error) {}
    func advertiser(_: MCNearbyServiceAdvertiser, didReceiveInvitationFromPeer peerID: MCPeerID, withContext _: Data?, invitationHandler: @escaping (Bool, MCSession?) -> Void) {
        invitationHandler(true, session)
    }
    func browser(_: MCNearbyServiceBrowser, foundPeer peerID: MCPeerID, withDiscoveryInfo _: [String : String]?) {
        browser.invitePeer(peerID, to: session, withContext: nil, timeout: 10)
    }
    func browser(_: MCNearbyServiceBrowser, lostPeer _: MCPeerID) {}
}
