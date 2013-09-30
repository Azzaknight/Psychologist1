//
//  HappinessViewController.m
//  Happiness
//
//  Created by Pamamarch on 17/09/2013.
//  Copyright (c) 2013 Finger Flick Games. All rights reserved.
//

#import "HappinessViewController.h"
#import "FaceView.h"

@interface HappinessViewController () <FaceViewDataSource>

@property (nonatomic, weak) IBOutlet FaceView* faceView;


@end



@implementation HappinessViewController

-(void) setHappiness:(int)happiness {
    
    if(_happiness != happiness) _happiness = happiness;
    [self.faceView setNeedsDisplay]; // Anytime our model changes we do redraw
    
}


-(void)setFaceView:(FaceView *)faceView {
    
    _faceView = faceView;
    UIPinchGestureRecognizer * pgr = [[UIPinchGestureRecognizer alloc] initWithTarget:self.faceView action:@selector(pinch:)];
    [self.faceView addGestureRecognizer:pgr];
    
    self.faceView.dataSource = self;
    
    UIPanGestureRecognizer *panrg = [[UIPanGestureRecognizer alloc]
                                     initWithTarget:self action:@selector(panSmile:)];
    [self.faceView addGestureRecognizer:panrg];

}


- (BOOL)shouldAutorotate {
    
    return YES; // support all orientations!
    
}


-(float)smileForFaceView:(FaceView *)sender
{
 
    return (self.happiness - 50) / 50.0;
    
}

-(void)panSmile:(UIPanGestureRecognizer*)panRecogniser
{
    if (panRecogniser.state == UIGestureRecognizerStateChanged ||
        panRecogniser.state == UIGestureRecognizerStateEnded) {
        
        CGPoint translation = [panRecogniser translationInView:self.faceView];
        //  Pan up to make it happier, pan down to make it sadder
        self.happiness -= translation.y / 2 ;
        [panRecogniser setTranslation:CGPointZero inView:self.faceView];
 
    }
    
    
}


//**************************************************************************
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
