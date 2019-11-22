//
//  HSYViewController.m
//  FFmpegKit
//
//  Created by 317398895@qq.com on 11/19/2019.
//  Copyright (c) 2019 317398895@qq.com. All rights reserved.
//

#import "HSYViewController.h"
#import "HSYFFmpegTools.h"

@interface HSYViewController ()

@end

@implementation HSYViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    HSYFFmpegTools *tools = [[HSYFFmpegTools alloc] initWithFilePath:[[NSBundle mainBundle] URLForResource:@"output" withExtension:@"mp4"].absoluteString];
    NSLog(@"tools = %@", tools);
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
