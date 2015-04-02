//
//  PlaySoundViewController.swift
//  Pitch Perfect
//
//  Created by Alvin Landicho on 3/11/15.
//  Copyright (c) 2015 Alvin Landicho. All rights reserved.
//

import UIKit
import AVFoundation


class PlaySoundViewController: UIViewController {
    
    var audioPlayer:AVAudioPlayer!
    var receivedAudio:RecordedAudio!
    var audioEngine:AVAudioEngine!
    var audioFile:AVAudioFile!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        audioEngine = AVAudioEngine()
        audioFile = AVAudioFile(forReading: receivedAudio.filePathUrl, error: nil)
        audioPlayer = AVAudioPlayer (contentsOfURL: receivedAudio.filePathUrl, error: nil)
        audioPlayer.enableRate = true
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    @IBAction func slowButton(sender: UIButton) {
    
        playAudioWithVariableRate(0.5)
    }
    
    
    @IBAction func fastButton(sender: UIButton) {
        
        playAudioWithVariableRate(1.5)
    }
    
    
    @IBAction func stopButton(sender: UIButton) {
        
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
    }
    
    
    @IBAction func playChipmunkAudio(sender: UIButton) {
        
        playAudioWithVariablePitch(1000)
    }
    
    
    @IBAction func playDarthvaderAudio(sender: UIButton) {
        playAudioWithVariablePitch(-1000)
    }
    
    //Function for Pitch:
    func playAudioWithVariablePitch(pitch: Float){
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        var audioPlayerNode = AVAudioPlayerNode()
        audioEngine.attachNode(audioPlayerNode)
        
        var changePitchEffect = AVAudioUnitTimePitch()
        changePitchEffect.pitch = pitch
        audioEngine.attachNode(changePitchEffect)
        
        audioEngine.connect(audioPlayerNode, to: changePitchEffect, format: nil)
        audioEngine.connect(changePitchEffect, to: audioEngine.outputNode, format: nil)
        
        audioPlayerNode.scheduleFile(audioFile, atTime: nil, completionHandler: nil)
        audioEngine.startAndReturnError(nil)
        
        //to play the sound through the iPhone speaker if headphone is not connected
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryAmbient, error: nil)
        
        audioPlayerNode.play()
    }
    
    
    //Function for Rate:
    func playAudioWithVariableRate(rate: Float) {
        audioPlayer.stop()
        audioEngine.stop()
        audioEngine.reset()
        
        audioPlayer.rate = rate
        audioPlayer.currentTime = 0.0
        
        
        //to play the sound through the iPhone speaker if headphone is not connected
        var session = AVAudioSession.sharedInstance()
        session.setCategory(AVAudioSessionCategoryAmbient, error: nil)
        
        audioPlayer.play()
    }
    
}
