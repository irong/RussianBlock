//
//  ViewController.m
//  RussianBlock
//
//  Created by Hazard on 15/5/4.
//  Copyright (c) 2015年 Hazard. All rights reserved.
//

#import "ViewController.h"
#import "RussianBlockView.h"

@interface ViewController ()
{
    RussianBlockView *_viewRussianBlock;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _viewRussianBlock = [[RussianBlockView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_viewRussianBlock];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)generateBlock
{

}

@end
