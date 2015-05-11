//
//  RussianBlockView.m
//  RussianBlock
//
//  Created by Hazard on 15/5/5.
//  Copyright (c) 2015年 Hazard. All rights reserved.
//

#import "RussianBlockView.h"
#import "GamePlayView.h"
#import "GameHandleView.h"

@interface RussianBlockView () <GameHandleViewDelegate>
{
    UIImageView *_imgViewBackGround;
    
    GamePlayView *_viewGamePlay;
    GameHandleView *_viewGameHandle;

}

@end

@implementation RussianBlockView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImage *imgBack = [UIImage imageNamed:@"tetris_back"];
        _imgViewBackGround = [[UIImageView alloc] initWithFrame:self.bounds];
        _imgViewBackGround.image = imgBack;
        [self addSubview:_imgViewBackGround];
        //游戏区
        _viewGamePlay = [[GamePlayView alloc] initWithFrame:CGRectMake(Left_GamePlayView, Top_GamePlayView, Width_GamePlayView, Height_GamePlayView)];
        [self addSubview:_viewGamePlay];
        //游戏控制区
        _viewGameHandle = [[GameHandleView alloc] initWithFrame:CGRectMake(Left_GameHandleView, Top_GameHandleView, Width_GameHandleView, Height_GameHandleView)];
        _viewGameHandle.delegate = self;
        [self addSubview:_viewGameHandle];
        
    }
    return self;
}


#pragma mark - GameHandleViewDelegate

//开始游戏
- (void)gameHandleViewStartGame:(GameHandleView *)gameHandleView
{
    [_viewGamePlay startGame];
}

//左移动
- (void)gameHandleViewMoveToLeft:(GameHandleView *)gameHandleView
{
    [_viewGamePlay moveToLeft];
}
//右移动
- (void)gameHandleViewMoveToRight:(GameHandleView *)gameHandleView
{
    [_viewGamePlay moveToRight];
}
//变换
- (void)gameHandleViewRoatation:(GameHandleView *)gameHandleView
{
    [_viewGamePlay roatation];
}
//下移动加速
- (void)gameHandleViewDownQuickly:(GameHandleView *)gameHandleView
{
    [_viewGamePlay downQucikly];
}


@end
