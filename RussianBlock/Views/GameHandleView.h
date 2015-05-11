//
//  GameHandleView.h
//  RussianBlock
//
//  Created by Hazard on 15/5/7.
//  Copyright (c) 2015年 Hazard. All rights reserved.
//

#import <UIKit/UIKit.h>

#define Left_GameHandleView 0
#define Top_GameHandleView 170
#define Width_GameHandleView 300
#define Height_GameHandleView 400


@protocol GameHandleViewDelegate ;


@interface GameHandleView : UIView

@property(nonatomic, assign) id<GameHandleViewDelegate> delegate;

@end

@protocol GameHandleViewDelegate <NSObject>

//开始游戏
- (void)gameHandleViewStartGame:(GameHandleView *)gameHandleView;
//左移动
- (void)gameHandleViewMoveToLeft:(GameHandleView *)gameHandleView;
//右移动
- (void)gameHandleViewMoveToRight:(GameHandleView *)gameHandleView;
//变换
- (void)gameHandleViewRoatation:(GameHandleView *)gameHandleView;
//下移动加速
- (void)gameHandleViewDownQuickly:(GameHandleView *)gameHandleView;

@end
