//
//  GamePlayView.h
//  RussianBlock
//
//  Created by Hazard on 15/5/5.
//  Copyright (c) 2015年 Hazard. All rights reserved.
//

#define Size_Block          16.0f
#define Column_Game_x         12
#define Row_Game_y            23
#define Left_GamePlayView   120.0f
#define Top_GamePlayView    16.0f
#define Width_GamePlayView  (Column_Game_x*Size_Block)
#define Height_GamePlayView (Row_Game_y*Size_Block)

#define Count_BlockType     7
#define Count_Block         4

#import <UIKit/UIKit.h>

@interface GamePlayView : UIView

- (void)startGame;
- (void)moveToLeft;
- (void)moveToRight;
- (void)roatation;
- (void)downQucikly;


@end
