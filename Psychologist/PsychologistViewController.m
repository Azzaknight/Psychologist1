//
//  PsychologistViewController.m
//  Psychologist
//
//  Created by Pamamarch on 29/09/2013.
//  Copyright (c) 2013 Finger Flick Games. All rights reserved.
//

#import "PsychologistViewController.h"
#import "HappinessViewController.h"

@interface PsychologistViewController ()

@property (nonatomic)int diagnosis;

@end

@implementation PsychologistViewController


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"ShowDiagnosis"]){
        [segue.destinationViewController setHappiness:self.diagnosis];
    } else if ([segue.identifier isEqualToString:@"Nuts"]) {
        [segue.destinationViewController setHappiness:5];
    } else if ([segue.identifier isEqualToString:@"Celebrity"]) {
        [segue.destinationViewController setHappiness:100];
    }else if ([segue.identifier isEqualToString:@"TvKook"]) {
        [segue.destinationViewController setHappiness:50];
    }
    
}


-(void)setAndShowDiagnosis:(float)happiness{
    
    self.diagnosis = happiness;
    [self performSegueWithIdentifier:@"ShowDiagnosis" sender:self];
    
}

- (IBAction)legsTied {
    
    [self setAndShowDiagnosis:10];
}

- (IBAction)crowd {
    
    [self setAndShowDiagnosis:40];
}

- (IBAction)flying {
    
    [self setAndShowDiagnosis:70];
}

- (IBAction)lottery {
    
    [self setAndShowDiagnosis:100];
}


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
