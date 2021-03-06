//
//  CallViewController.swift
//  HomeViewing
//
//  Created by Patrick Cho on 8/5/17.
//  Copyright © 2017 TinyWhale. All rights reserved.
//

import UIKit

import TwilioVideo

class CallViewController: UIViewController {

    // MARK: View Controller Members
    
    // Configure access token manually for testing, if desired! Create one manually in the console
    // at https://www.twilio.com/user/account/video/dev-tools/testing-tools
    var accessToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiIsImN0eSI6InR3aWxpby1mcGE7dj0xIn0.eyJqdGkiOiJTSzM2MzExOTY5NWQ3ZDhlYjExY2E3NmIxNWZlZDQyYTQwLTE1MDE5NDE4MjAiLCJncmFudHMiOnsiaWRlbnRpdHkiOiJmaXJzdF91c2VyIn0sImlzcyI6IlNLMzYzMTE5Njk1ZDdkOGViMTFjYTc2YjE1ZmVkNDJhNDAiLCJuYmYiOjE1MDE5NDE4MjAsImV4cCI6MTUwMTk1MjYyMCwic3ViIjoiQldmaU1GOEpzOUdCV0JFSEZjdmh6WWZuOHFPUGt5WWsifQ.Tl6UOjAQSn3TQm7MCs0xvooZiX8TTIfP-m5EqqATdtc"
    
    var accessToken2 = "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiIsImN0eSI6InR3aWxpby1mcGE7dj0xIn0.eyJqdGkiOiJTSzM2MzExOTY5NWQ3ZDhlYjExY2E3NmIxNWZlZDQyYTQwLTE1MDE5NDE0NzciLCJncmFudHMiOnsiaWRlbnRpdHkiOiJzZWNvbmRfdXNlciIsInZpZGVvIjp7InJvb20iOiJob29kaXNydXB0X2RlbW8ifX0sImlzcyI6IlNLMzYzMTE5Njk1ZDdkOGViMTFjYTc2YjE1ZmVkNDJhNDAiLCJuYmYiOjE1MDE5NDE0NzcsImV4cCI6MTUwMTk1MjI3Nywic3ViIjoiQldmaU1GOEpzOUdCV0JFSEZjdmh6WWZuOHFPUGt5WWsifQ.KFVUqVPJzPcTiZSUhWxkg1xK-kN83aXfkH1GpJMCi08"
    
    // Configure remote URL to fetch token from
    var tokenUrl = "http://localhost:8000/token.php"
    
    // Video SDK components
    var room: TVIRoom?
    var camera: TVICameraCapturer?
    var localVideoTrack: TVILocalVideoTrack?
    var localAudioTrack: TVILocalAudioTrack?
    var participant: TVIParticipant?
    var remoteView: TVIVideoView?
    
    // MARK: UI Element Outlets and handles
    
    // `TVIVideoView` created from a storyboard
    var previewView: TVIVideoView?
    var connectButton: UIButton?
    var disconnectButton: UIButton?
    var messageLabel: UILabel?
    var roomTextField: UITextField?
    var roomLine: UIView?
    var roomLabel: UILabel?
    var micButton: UIButton?
    
    // MARK: UIViewController
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // PREVIEW
        self.previewView = TVIVideoView() // frame: CGRect(x: 244, y: 497, width: 120, height: 160)
        previewView?.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(previewView!)
        let pvWidthConstraint = NSLayoutConstraint(item: previewView!, attribute: .width, relatedBy: .equal,
                                                 toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 120)
        let pvHeightConstraint = NSLayoutConstraint(item: previewView!, attribute: .height, relatedBy: .equal,
                                                  toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 160)
        let pvXConstraint = NSLayoutConstraint(item: previewView!, attribute: .trailing, relatedBy: .equal, toItem: self.view, attribute: .trailing, multiplier: 1, constant: -10)
        let pvYConstraint = NSLayoutConstraint(item: previewView!, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: -10)
        NSLayoutConstraint.activate([pvWidthConstraint, pvHeightConstraint, pvXConstraint, pvYConstraint])
        
        // CONNECT BUTTON
        self.connectButton = UIButton() // frame: CGRect(x: 16, y: 325, width: 343, height: 44)
        connectButton?.backgroundColor = .red
        connectButton?.setTitle("Call Frodo", for: .normal)
        connectButton?.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(connectButton!)
        let widthConstraint = NSLayoutConstraint(item: connectButton!, attribute: .width, relatedBy: .equal,
                                                 toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 343)
        let heightConstraint = NSLayoutConstraint(item: connectButton!, attribute: .height, relatedBy: .equal,
                                                  toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 44)
        let xConstraint = NSLayoutConstraint(item: connectButton!, attribute: .centerX, relatedBy: .equal, toItem: self.view, attribute: .centerX, multiplier: 1, constant: 0)
        let yConstraint = NSLayoutConstraint(item: connectButton!, attribute: .centerY, relatedBy: .equal, toItem: self.view, attribute: .centerY, multiplier: 1, constant: 0)
        NSLayoutConstraint.activate([widthConstraint, heightConstraint, xConstraint, yConstraint])
        
        // DISCONNECT BUTTON
        self.disconnectButton = UIButton() // frame: CGRect(x: 11, y: 613, width: 80, height: 44)
        disconnectButton?.backgroundColor = .red
        disconnectButton?.setTitle("Disconnect", for: .normal)
        disconnectButton?.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(disconnectButton!)
        let dcWidthConstraint = NSLayoutConstraint(item: disconnectButton!, attribute: .width, relatedBy: .equal,
                                                   toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 120)
        let dcHeightConstraint = NSLayoutConstraint(item: disconnectButton!, attribute: .height, relatedBy: .equal,
                                                    toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 44)
        let dcXConstraint = NSLayoutConstraint(item: disconnectButton!, attribute: .leading, relatedBy: .equal, toItem: self.view, attribute: .leading, multiplier: 1, constant: 10)
        let dcYConstraint = NSLayoutConstraint(item: disconnectButton!, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: -10)
        NSLayoutConstraint.activate([dcWidthConstraint, dcHeightConstraint, dcXConstraint, dcYConstraint])
        
        self.messageLabel = UILabel() // frame: CGRect(x: 0, y: 20, width: 375, height: 16)
        self.roomTextField = UITextField() // frame: CGRect(x: 16, y: 279, width: 343, height: 30)
        self.roomLine = UIView() // frame: CGRect(x: 16, y: 304, width: 343, height: 2)
        roomLine?.backgroundColor = .black
        roomTextField?.text = "hoodisrupt_demo"
        self.roomLabel = UILabel()
        
        // MIC BUTTON
        self.micButton = UIButton(frame: CGRect(x: 101, y: 613, width: 80, height: 44))
        micButton?.setTitle("Mute", for: .normal)
        micButton?.backgroundColor = .red
        micButton?.addTarget(self, action: #selector(toggleMic(sender:)), for: .touchUpInside)
        micButton?.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(micButton!)
        let micWidthConstraint = NSLayoutConstraint(item: micButton!, attribute: .width, relatedBy: .equal,
                                                   toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 120)
        let micHeightConstraint = NSLayoutConstraint(item: micButton!, attribute: .height, relatedBy: .equal,
                                                    toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 44)
        let micXConstraint = NSLayoutConstraint(item: micButton!, attribute: .leading, relatedBy: .equal, toItem: disconnectButton!, attribute: .trailing, multiplier: 1, constant: 10)
        let micYConstraint = NSLayoutConstraint(item: micButton!, attribute: .bottom, relatedBy: .equal, toItem: self.view, attribute: .bottom, multiplier: 1, constant: -10)
        NSLayoutConstraint.activate([micWidthConstraint, micHeightConstraint, micXConstraint, micYConstraint])
        
        connectButton?.addTarget(self, action: #selector(connect(sender:)), for: .touchUpInside)
        disconnectButton?.addTarget(self, action: #selector(disconnect(sender:)), for: .touchUpInside)
        
        
        
        
        
        
        self.view.addSubview(messageLabel!)
        self.view.addSubview(roomTextField!)
        self.view.addSubview(roomLine!)
        self.view.addSubview(roomLabel!)
    
        if PlatformUtils.isSimulator {
            self.previewView?.removeFromSuperview()
        } else {
            // Preview our local camera track in the local video preview view.
            self.startPreview()
        }
        
        // Disconnect and mic button will be displayed when the Client is connected to a Room.
        self.disconnectButton?.isHidden = true
        self.micButton?.isHidden = true
        
        self.roomTextField!.delegate = self
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(CallViewController.dismissKeyboard))
        self.view.addGestureRecognizer(tap)
    }
    
    func setupRemoteVideoView() {
        // Creating `TVIVideoView` programmatically
        self.remoteView = TVIVideoView.init(frame: CGRect.zero, delegate:self)
        
        self.view.insertSubview(self.remoteView!, at: 0)
        
        // `TVIVideoView` supports scaleToFill, scaleAspectFill and scaleAspectFit
        // scaleAspectFit is the default mode when you create `TVIVideoView` programmatically.
        self.remoteView!.contentMode = .scaleAspectFit;
        
        let centerX = NSLayoutConstraint(item: self.remoteView!,
                                         attribute: NSLayoutAttribute.centerX,
                                         relatedBy: NSLayoutRelation.equal,
                                         toItem: self.view,
                                         attribute: NSLayoutAttribute.centerX,
                                         multiplier: 1,
                                         constant: 0);
        self.view.addConstraint(centerX)
        let centerY = NSLayoutConstraint(item: self.remoteView!,
                                         attribute: NSLayoutAttribute.centerY,
                                         relatedBy: NSLayoutRelation.equal,
                                         toItem: self.view,
                                         attribute: NSLayoutAttribute.centerY,
                                         multiplier: 1,
                                         constant: 0);
        self.view.addConstraint(centerY)
        let width = NSLayoutConstraint(item: self.remoteView!,
                                       attribute: NSLayoutAttribute.width,
                                       relatedBy: NSLayoutRelation.equal,
                                       toItem: self.view,
                                       attribute: NSLayoutAttribute.width,
                                       multiplier: 1,
                                       constant: 0);
        self.view.addConstraint(width)
        let height = NSLayoutConstraint(item: self.remoteView!,
                                        attribute: NSLayoutAttribute.height,
                                        relatedBy: NSLayoutRelation.equal,
                                        toItem: self.view,
                                        attribute: NSLayoutAttribute.height,
                                        multiplier: 1,
                                        constant: 0);
        self.view.addConstraint(height)
    }
    
    // MARK: IBActions
    func connect(sender: AnyObject) {
        // Configure access token either from server or manually.
        // If the default wasn't changed, try fetching from server.
        if (accessToken == "TWILIO_ACCESS_TOKEN") {
            do {
                accessToken = try TokenUtils.fetchToken(url: tokenUrl)
            } catch {
                let message = "Failed to fetch access token"
                logMessage(messageText: message)
                return
            }
        }
        
        // Prepare local media which we will share with Room Participants.
        self.prepareLocalMedia()
        
        // Preparing the connect options with the access token that we fetched (or hardcoded).
        let connectOptions = TVIConnectOptions.init(token: accessToken) { (builder) in
            
            // Use the local media that we prepared earlier.
            builder.audioTracks = self.localAudioTrack != nil ? [self.localAudioTrack!] : [TVILocalAudioTrack]()
            builder.videoTracks = self.localVideoTrack != nil ? [self.localVideoTrack!] : [TVILocalVideoTrack]()
            
            // The name of the Room where the Client will attempt to connect to. Please note that if you pass an empty
            // Room `name`, the Client will create one for you. You can get the name or sid from any connected Room.
            builder.roomName = self.roomTextField!.text
        }
        
        // Connect to the Room using the options we provided.
        room = TwilioVideo.connect(with: connectOptions, delegate: self)
        
        logMessage(messageText: "Attempting to connect to room \(String(describing: self.roomTextField!.text))")
        
        self.showRoomUI(inRoom: true)
        self.dismissKeyboard()
    }
    
    func disconnect(sender: AnyObject) {
        self.room!.disconnect()
        logMessage(messageText: "Attempting to disconnect from room \(room!.name)")
    }
    
    func toggleMic(sender: AnyObject) {
        if (self.localAudioTrack != nil) {
            self.localAudioTrack?.isEnabled = !(self.localAudioTrack?.isEnabled)!
            
            // Update the button title
            if (self.localAudioTrack?.isEnabled == true) {
                self.micButton!.setTitle("Mute", for: .normal)
            } else {
                self.micButton!.setTitle("Unmute", for: .normal)
            }
        }
    }
    
    // MARK: Private
    func startPreview() {
        if PlatformUtils.isSimulator {
            return
        }
        
        // Preview our local camera track in the local video preview view.
        camera = TVICameraCapturer(source: .frontCamera, delegate: self)
        localVideoTrack = TVILocalVideoTrack.init(capturer: camera!)
        if (localVideoTrack == nil) {
            logMessage(messageText: "Failed to create video track")
        } else {
            // Add renderer to video track for local preview
            localVideoTrack!.addRenderer(self.previewView!)
            
            logMessage(messageText: "Video track created")
            
            // We will flip camera on tap.
            let tap = UITapGestureRecognizer(target: self, action: #selector(CallViewController.flipCamera))
            self.previewView!.addGestureRecognizer(tap)
        }
    }
    
    func flipCamera() {
        if (self.camera?.source == .frontCamera) {
            self.camera?.selectSource(.backCameraWide)
        } else {
            self.camera?.selectSource(.frontCamera)
        }
    }
    
    func prepareLocalMedia() {
        
        // We will share local audio and video when we connect to the Room.
        
        // Create an audio track.
        if (localAudioTrack == nil) {
            localAudioTrack = TVILocalAudioTrack.init()
            
            if (localAudioTrack == nil) {
                logMessage(messageText: "Failed to create audio track")
            }
        }
        
        // Create a video track which captures from the camera.
        if (localVideoTrack == nil) {
            self.startPreview()
        }
    }
    
    // Update our UI based upon if we are in a Room or not
    func showRoomUI(inRoom: Bool) {
        self.connectButton?.isHidden = inRoom
        self.roomTextField?.isHidden = inRoom
        self.roomLine?.isHidden = inRoom
        self.roomLabel?.isHidden = inRoom
        self.micButton?.isHidden = !inRoom
        self.disconnectButton?.isHidden = !inRoom
        UIApplication.shared.isIdleTimerDisabled = inRoom
    }
    
    func dismissKeyboard() {
        if (self.roomTextField!.isFirstResponder) {
            self.roomTextField!.resignFirstResponder()
        }
    }
    
    func cleanupRemoteParticipant() {
        if ((self.participant) != nil) {
            if ((self.participant?.videoTracks.count)! > 0) {
                self.participant?.videoTracks[0].removeRenderer(self.remoteView!)
                self.remoteView?.removeFromSuperview()
                self.remoteView = nil
            }
        }
        self.participant = nil
    }
    
    func logMessage(messageText: String) {
        messageLabel!.text = messageText
    }
}

// MARK: UITextFieldDelegate
extension CallViewController : UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.connect(sender: textField)
        return true
    }
}

// MARK: TVIRoomDelegate
extension CallViewController : TVIRoomDelegate {
    func didConnect(to room: TVIRoom) {
        
        // At the moment, this example only supports rendering one Participant at a time.
        
        logMessage(messageText: "Connected to room \(room.name) as \(String(describing: room.localParticipant?.identity))")
        
        if (room.participants.count > 0) {
            self.participant = room.participants[0]
            self.participant?.delegate = self
        }
    }
    
    func room(_ room: TVIRoom, didDisconnectWithError error: Error?) {
        logMessage(messageText: "Disconncted from room \(room.name), error = \(String(describing: error))")
        
        self.cleanupRemoteParticipant()
        self.room = nil
        
        self.showRoomUI(inRoom: false)
    }
    
    func room(_ room: TVIRoom, didFailToConnectWithError error: Error) {
        logMessage(messageText: "Failed to connect to room with error")
        self.room = nil
        
        self.showRoomUI(inRoom: false)
    }
    
    func room(_ room: TVIRoom, participantDidConnect participant: TVIParticipant) {
        if (self.participant == nil) {
            self.participant = participant
            self.participant?.delegate = self
        }
        logMessage(messageText: "Room \(room.name), Participant \(participant.identity) connected")
    }
    
    func room(_ room: TVIRoom, participantDidDisconnect participant: TVIParticipant) {
        if (self.participant == participant) {
            cleanupRemoteParticipant()
        }
        logMessage(messageText: "Room \(room.name), Participant \(participant.identity) disconnected")
    }
}

// MARK: TVIParticipantDelegate
extension CallViewController : TVIParticipantDelegate {
    func participant(_ participant: TVIParticipant, addedVideoTrack videoTrack: TVIVideoTrack) {
        logMessage(messageText: "Participant \(participant.identity) added video track")
        
        if (self.participant == participant) {
            setupRemoteVideoView()
            videoTrack.addRenderer(self.remoteView!)
        }
    }
    
    func participant(_ participant: TVIParticipant, removedVideoTrack videoTrack: TVIVideoTrack) {
        logMessage(messageText: "Participant \(participant.identity) removed video track")
        
        if (self.participant == participant) {
            videoTrack.removeRenderer(self.remoteView!)
            self.remoteView?.removeFromSuperview()
            self.remoteView = nil
        }
    }
    
    func participant(_ participant: TVIParticipant, addedAudioTrack audioTrack: TVIAudioTrack) {
        logMessage(messageText: "Participant \(participant.identity) added audio track")
        
    }
    
    func participant(_ participant: TVIParticipant, removedAudioTrack audioTrack: TVIAudioTrack) {
        logMessage(messageText: "Participant \(participant.identity) removed audio track")
    }
    
    func participant(_ participant: TVIParticipant, enabledTrack track: TVITrack) {
        var type = ""
        if (track is TVIVideoTrack) {
            type = "video"
        } else {
            type = "audio"
        }
        logMessage(messageText: "Participant \(participant.identity) enabled \(type) track")
    }
    
    func participant(_ participant: TVIParticipant, disabledTrack track: TVITrack) {
        var type = ""
        if (track is TVIVideoTrack) {
            type = "video"
        } else {
            type = "audio"
        }
        logMessage(messageText: "Participant \(participant.identity) disabled \(type) track")
    }
}

// MARK: TVIVideoViewDelegate
extension CallViewController : TVIVideoViewDelegate {
    func videoView(_ view: TVIVideoView, videoDimensionsDidChange dimensions: CMVideoDimensions) {
        self.view.setNeedsLayout()
    }
}

// MARK: TVICameraCapturerDelegate
extension CallViewController : TVICameraCapturerDelegate {
    func cameraCapturer(_ capturer: TVICameraCapturer, didStartWith source: TVICameraCaptureSource) {
        self.previewView?.shouldMirror = (source == .frontCamera)
    }
}

