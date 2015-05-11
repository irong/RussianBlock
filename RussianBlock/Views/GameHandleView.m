//
//  GameHandleView.m
//  RussianBlock
//
//  Created by Hazard on 15/5/7.
//  Copyright (c) 2015年 Hazard. All rights reserved.
//

#import "GameHandleView.h"

@interface GameHandleView ()
{
    UIButton *_btnLeftMove;
    UIButton *_btnRightMove;
    UIButton *_btnSwitch;
    UIButton *_btnDown;
    UIButton *_btnStart;
}

@end

@implementation GameHandleView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _btnStart = [[UIButton alloc] initWithFrame:CGRectMake(6, 240, 100, 50)];
        [_btnStart setTitle:@"开始游戏" forState:UIControlStateNormal];
        [_btnStart addTarget:self action:@selector(startGame)
                forControlEvents:UIControlEventTouchUpInside];
        _btnLeftMove = [[UIButton alloc] initWithFrame:CGRectMake(0, 120, 50, 50)];
        [_btnLeftMove setTitle:@"左移" forState:UIControlStateNormal];
//        _btnLeftMove.backgroundColor = [UIColor yellowColor];
        [_btnLeftMove addTarget:self action:@selector(moveToLeft)
               forControlEvents:UIControlEventTouchUpInside];
        _btnRightMove = [[UIButton alloc] initWithFrame:CGRectMake(60, 120, 50, 50)];
        [_btnRightMove setTitle:@"右移" forState:UIControlStateNormal];
        [_btnRightMove addTarget:self action:@selector(moveToRight)
               forControlEvents:UIControlEventTouchUpInside];
        _btnSwitch = [[UIButton alloc] initWithFrame:CGRectMake(35, 60, 50, 50)];
        [_btnSwitch setTitle:@"变形" forState:UIControlStateNormal];
        [_btnSwitch addTarget:self action:@selector(roatation)
               forControlEvents:UIControlEventTouchUpInside];
        _btnDown = [[UIButton alloc] initWithFrame:CGRectMake(35, 180, 50, 50)];
        [_btnDown setTitle:@"下移" forState:UIControlStateNormal];
        [_btnDown addTarget:self action:@selector(downQucikly)
               forControlEvents:UIControlEventTouchUpInside];
        
        [self addSubview:_btnStart];
        [self addSubview:_btnLeftMove];
        [self addSubview:_btnRightMove];
        [self addSubview:_btnSwitch];
        [self addSubview:_btnDown];

    }
    return self;
}


#pragma mark - Private

- (void)startGame
{
    [self.delegate gameHandleViewStartGame:self];
}

- (void)moveToLeft
{
    [self.delegate gameHandleViewMoveToLeft:self];
}

- (void)moveToRight
{
    [self.delegate gameHandleViewMoveToRight:self];
}

- (void)roatation
{
    [self.delegate gameHandleViewRoatation:self];
}

- (void)downQucikly
{
    [self.delegate gameHandleViewDownQuickly:self];
}


@end
