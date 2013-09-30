//
//  FaceView.m
//  Happiness
//
//  Created by Pamamarch on 17/09/2013.
//  Copyright (c) 2013 Finger Flick Games. All rights reserved.
//

#import "FaceView.h"

@interface FaceView ()


@end

@implementation FaceView

#define DEFAULT_SCALE 0.90

@synthesize scale = _scale;

- (CGFloat)scale
{
    if (!_scale)
        return DEFAULT_SCALE;
    else
        return _scale;
}

-(void)setScale:(CGFloat)scale
{
    if (_scale != scale) {
        _scale = scale;
        [self setNeedsDisplay];
    }
}


//******************* Gesture recogniser handler

-(void)pinch:(UIPinchGestureRecognizer *)gesture
{
    if ((gesture.state == UIGestureRecognizerStateChanged) ||
        (gesture.state == UIGestureRecognizerStateEnded)) {
        self.scale *= gesture.scale; //adjust our scale
        gesture.scale = 1; // reset the scale (future changes are incremental, not cumulative
    }
}



//******************** Our Initialization Methods

-(void) setUp
{
    self.contentMode = UIViewContentModeRedraw; // If bounds changes then redraw
}


- (void)awakeFromNib
{
    [self setUp]; // Get initialized when we come out of story board
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        [self setUp];  // get initialised when someone calls alloc/initWithFrame
    }
    return self;
}

//********************** Drawing Code

// Helper method to draw a circle

-(void) drawCircleAtPoint:(CGPoint)p withRadius:(CGFloat)radius inContext:(CGContextRef) contextRef
{
    UIGraphicsPushContext(contextRef);
    CGContextBeginPath(contextRef);
    CGContextAddArc(contextRef, p.x, p.y, radius, 0, 2*M_PI, YES); // 360 degrees. degrees are in radians -> 0 to 2pi
    CGContextStrokePath(contextRef);
    UIGraphicsPopContext();
    
}



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGPoint midPoint;  // center of our bounds in our co-ordinate system
    midPoint.x = self.bounds.origin.x + self.bounds.size.width/2;
    midPoint.y = self.bounds.origin.y + self.bounds.size.height/2;
    
    CGFloat size = self.bounds.size.width/2;
    if (self.bounds.size.height < self.bounds.size.width) size = self.bounds.size.height / 2;
    size*= self.scale;
    
    
    CGContextSetLineWidth(context, 5.0);
    [[UIColor blueColor] setStroke];
    
    [self drawCircleAtPoint:midPoint withRadius:size inContext:context]; // This is the head! Draw and see
    
#define EYES_H 0.35
#define EYES_V 0.35
#define EYES_RADIUS 0.10
    
    CGPoint eyePoint;
    eyePoint.x = midPoint.x - size * EYES_H;
    eyePoint.y = midPoint.y - size * EYES_V;
    
    [self drawCircleAtPoint:eyePoint withRadius:(size * EYES_RADIUS) inContext:context];
    eyePoint.x += size * EYES_H * 2;
    [self drawCircleAtPoint:eyePoint withRadius:(size * EYES_RADIUS) inContext:context];

#define MOUTH_H 0.45
#define MOUTH_V 0.40
#define MOUTH_SMILE 0.25
    
    CGPoint mouthStart;
    mouthStart.x = midPoint.x - MOUTH_H * size;
    mouthStart.y = midPoint.y + MOUTH_V * size;
    CGPoint mouthEnd = mouthStart;
    mouthEnd.x += MOUTH_H * size * 2;
    CGPoint mouthCP1 = mouthStart;
    mouthCP1.x += MOUTH_H * size * 2/3;
    CGPoint mouthCP2 = mouthEnd;
    mouthCP2.x -= MOUTH_H * size * 2/3;
    
    //float smile = 1.0; // this should be delegated! it's our View's data!
    float smile = [self.dataSource smileForFaceView:self]; // delegated to the datasource. We could have set the datasource in the storyboard as well.
    
    // protection to make sure that datasource does not break the view
    if (smile < -1) smile = -1;
    if (smile > 1) smile = 1;
    
    CGFloat smileOffset = MOUTH_SMILE * size * smile;
    mouthCP1.y += smileOffset;
    mouthCP2.y += smileOffset;
    
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, mouthStart.x, mouthStart.y);
    CGContextAddCurveToPoint(context, mouthCP1.x, mouthCP2.y, mouthCP2.x, mouthCP2.y, mouthEnd.x, mouthEnd.y); // bezier curve
    CGContextStrokePath(context);

    // draw an arc as a smile
    
}

@end
