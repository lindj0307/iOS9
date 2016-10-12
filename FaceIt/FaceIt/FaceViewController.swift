//
//  ViewController.swift
//  FaceIt
//
//  Created by 林东杰 on 9/26/16.
//  Copyright © 2016 Joey. All rights reserved.
//

import UIKit

class FaceViewController: UIViewController {
    
    // MARK: - Constants
    
    @IBOutlet weak var faceView: FaceView! {
        didSet {
            faceView.addGestureRecognizer(UIPinchGestureRecognizer(target: faceView, action: #selector(FaceView.changeScale(recognizer:))))
            let happierSwiperGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(FaceViewController.increaseHappiness))
            happierSwiperGestureRecognizer.direction  = .up
            faceView.addGestureRecognizer(happierSwiperGestureRecognizer)
            let sadderSwiperGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(FaceViewController.decreaseHappiness))
            sadderSwiperGestureRecognizer.direction  = .down
            faceView.addGestureRecognizer(sadderSwiperGestureRecognizer)
            updateUI()
        }
    }
    // MARK: - Variables
    var expression = FacialExpression(eyes: .Closed, eyeBrows: .Relaxed, mouth: .Smirk) {
        didSet {
            updateUI()
        }
    }
    
    private var mouthCurvature = [FacialExpression.Mouth.Frown: -1.0,.Grin:0.5,.Smile:1.0, .Smirk: -0.5, .Neutral: 0.0]
    private var eyeBrowTilts = [FacialExpression.EyeBrows.Relaxed: 0.5, .Normal:0.0, .Furrowed:-0.5]
    // MARK: - Properties
    
    // MARK: - Life Cycle
    
    // MARK: - TableView Data Source
    
    // MARK: - TableView Delegate
    
    // MARK: - Custom Delegate
    
    // MARK: - Event Response
    
    // MARK: - Private Methods
    private func updateUI() {
        switch expression.eyes {
        case .Open: faceView.eyesOpen = true
        case .Closed: faceView.eyesOpen = false
        case .Squinting: faceView.eyesOpen = false
        }
        faceView.mouthCurvature = mouthCurvature[expression.mouth] ?? 0.0
        faceView.eyeBrowTilt = eyeBrowTilts[expression.eyeBrows] ?? 0.0
    }
    
    @IBAction func toggleEyes(_ sender: UITapGestureRecognizer) {
        switch expression.eyes {
        case .Open:
            expression.eyes = .Closed
        case .Closed:
            expression.eyes = .Open
        case .Squinting: break
        }
    }
    func increaseHappiness() {
        expression.mouth = expression.mouth.happierMouth()
    }
    
    func decreaseHappiness() {
        expression.mouth = expression.mouth.sadderMout()
    }
    // MARK: - Navigation
    
    


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

