//
//  FaceView.h
//  Happiness
//
//  Created by Pamamarch on 17/09/2013.
//  Copyright (c) 2013 Finger Flick Games. All rights reserved.
//

#import <UIKit/UIKit.h>
@class FaceView;

@protocol FaceViewDataSource <NSObject>

// So this is like delegation, but it is asking some other object to be the delegate for providing the Data that the faceview requires, in this case, the smiliness or the happiness!
// Also whenever delegation like this is done, we usually pass ourself as an argument. Who is asking for this to be delegated, so that the delegated class can ask some questions if required !

-(float)smileForFaceView:(FaceView *)sender;

@end


@interface FaceView : UIView

@property (nonatomic) CGFloat scale;

-(void)pinch:(UIPinchGestureRecognizer *)gesture;

@property (nonatomic, weak) IBOutlet id <FaceViewDataSource> dataSource;

@end
