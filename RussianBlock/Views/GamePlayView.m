//
//  GamePlayView.m
//  RussianBlock
//
//  Created by Hazard on 15/5/5.
//  Copyright (c) 2015年 Hazard. All rights reserved.
//

#import "GamePlayView.h"

enum{
    BlockType_None=-1,
    BlockType_tian,
    BlockType_qi,
    BlockType_fanqi,
    BlockType_ti,
    BlockType_yi,
    BlockType_zi,
    BlockType_fanzi,
};
typedef NSUInteger BlockType;
enum{
    GameStatus_Over = 0,
    GameStatus_Run,
    GameStatus_Pause,
    
};
typedef NSUInteger GameStatus;

@interface GamePlayView ()
{
    UIImageView *_imgViewTrixUnit[Column_Game_x][Row_Game_y];
    BOOL _statusTrixUnit[Column_Game_x][Row_Game_y];
    BlockType _typeTrixUnit[Column_Game_x][Row_Game_y];
    NSString * _blockTemplate[Count_BlockType];
    UIImage *_imgBlockUnit[Count_BlockType];
    CGPoint _pointCurrBlock[Count_Block];
    
    BlockType _typeCurrBlock;
    GameStatus _gameStatus;
    
    NSTimer *_timer;
    
    //初始位置
    int _x;
    int _y;
}

@end

@implementation GamePlayView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor redColor];
        for (int c = 0; c< Column_Game_x; c++) {
            for (int r = 0; r< Row_Game_y; r++) {
                if (!_imgViewTrixUnit[c][r]) {
                    _imgViewTrixUnit[c][r] = [[UIImageView alloc] initWithFrame:CGRectMake(c*Size_Block, r*Size_Block, Size_Block, Size_Block)];
                    [self addSubview:_imgViewTrixUnit[c][r]];
                }
                _statusTrixUnit[c][r] = NO;
                _typeTrixUnit[c][r] = BlockType_None;

            }
        }
        //初始化切割小方块图片
        UIImage *imageBlock = [UIImage imageNamed:@"tetris_brick"];
        for (int i = 0; i< Count_BlockType; i++) {
            UIGraphicsBeginImageContext(CGSizeMake(Size_Block, Size_Block));
            [imageBlock drawInRect:CGRectMake(-i*Size_Block, 0, imageBlock.size.width, imageBlock.size.height)];
            _imgBlockUnit[i] = UIGraphicsGetImageFromCurrentImageContext();
            UIGraphicsEndImageContext();
                    }
        //初始化 Block模板
        _blockTemplate[BlockType_tian] = @"00100111";
        _blockTemplate[BlockType_qi] = @"00101112";
        _blockTemplate[BlockType_fanqi] = @"00100102";
        _blockTemplate[BlockType_ti] = @"00102011";
        _blockTemplate[BlockType_yi] = @"00102030";
        _blockTemplate[BlockType_zi] = @"00101121";
        _blockTemplate[BlockType_fanzi] = @"10200111";
        
        _x =5;
        _y = -2;
        _typeCurrBlock = BlockType_None;
        _gameStatus = GameStatus_Over;

        
    }
    return self;
}

#pragma mark -Public

- (void)startGame
{
    if (_gameStatus == GameStatus_Over) {
        //生成新的block
        [self generateBlock];
        //生成计时器
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(timer:) userInfo:nil repeats:YES];
    }else if (_gameStatus == GameStatus_Pause) {
        
    }else{
        return;
    }


}

- (void)moveToLeft
{
    //先检测碰撞或者是否越界
    BOOL flag = NO;
    for (int p = 0; p < 4; p++) {
        int x = _pointCurrBlock[p].x -1;
        int y = _pointCurrBlock[p].y;
        for (int n = 0 ; n < 4; n++) {
            if (_pointCurrBlock[n].y == y && _pointCurrBlock[n].x == x) {
                flag = YES;
                break;
            }
        }
        //如果当前 block 的某个方块的左方是当前 block 中已经包括的就过滤，只判断block 中左边界的方块
        if (flag) {
            flag = NO;
            continue;
        }
        BOOL bockStatus = _statusTrixUnit[x][y];
        //如果检测到碰撞或者到边界
        if (bockStatus || x < 0) {
            return;
        }
    }
    //再擦除之前的 block
    for (int a = 0;a < 4 ; a++) {
        [self clearBlockSrateWith:_pointCurrBlock[a].x y:_pointCurrBlock[a].y];
    }
    //更新当前block的状态
    for (int i = 0; i < 4; i++) {
        _pointCurrBlock[i].x--;
        int x = _pointCurrBlock[i].x;
        int y = _pointCurrBlock[i].y;
        [self updateBlockStateWithType:x y:y i:i];
        
    }
}

- (void)moveToRight
{
    //先检测碰撞或者是否越界
    BOOL flag = NO;
    for (int p = 0; p < 4; p++) {
        int x = _pointCurrBlock[p].x +1;
        int y = _pointCurrBlock[p].y;
        for (int n = 0 ; n < 4; n++) {
            if (_pointCurrBlock[n].y == y && _pointCurrBlock[n].x == x) {
                flag = YES;
                break;
            }
        }
        //如果当前 block 的某个方块的右方是当前 block 中已经包括的就过滤，只判断block 中右边界的方块
        if (flag) {
            flag = NO;
            continue;
        }
        BOOL bockStatus = _statusTrixUnit[x][y];
        //如果检测到碰撞或者到边界
        if (bockStatus || x >= Column_Game_x) {
            return;
        }
    }
    //擦除之前的 block
    for (int a = 0;a < 4 ; a++) {
        [self clearBlockSrateWith:_pointCurrBlock[a].x y:_pointCurrBlock[a].y];
    }
    //更新当前block的状态
    for (int i = 0; i < 4; i++) {
        _pointCurrBlock[i].x++;
        int x = _pointCurrBlock[i].x;
        int y = _pointCurrBlock[i].y;
        [self updateBlockStateWithType:x y:y i:i];
        
    }
}

- (void)roatation
{
    
}

- (void)downQucikly
{
    [self downBlock];
}

#pragma mark -Private

- (void)generateBlock
{
    srand( (unsigned)time( NULL ) );
    BlockType blockType = rand()%Count_BlockType;
    _typeCurrBlock = blockType;

    //获取block的索引值
    NSString *strIndex = _blockTemplate[blockType];
    //设置索引值位置的方块的状态和类型,图片,坐标
    for (int i= 0; i< 4; i++) {
        NSRange  range = NSMakeRange(i*2, 2);
        NSString *strPoint = [strIndex substringWithRange:range];
        int x = [[strPoint substringWithRange:NSMakeRange(0, 1)] intValue] + _x;
        int y = [[strPoint substringWithRange:NSMakeRange(1, 1)] intValue] + _y;
        [self updateBlockStateWithType:x y:y i:i];
        
    }
    
}

- (void)downBlock
{
    BOOL flag = NO;
    for (int p = 0; p < 4; p++) {
        int x = _pointCurrBlock[p].x;
        int y = _pointCurrBlock[p].y + 1;
        for (int n = 0 ; n < 4; n++) {
            if (_pointCurrBlock[n].y == y && _pointCurrBlock[n].x == x) {
                flag = YES;
                break;
            }
        }
        //如果当前 block 的某个方块的下方是当前 block 中已经包括的就过滤，只判断block 中最下方的方块
        if (flag) {
            flag = NO;
            continue;
        }
        BOOL bockStatus = _statusTrixUnit[x][y];
        //如果检测到碰撞或者到底部，保持现状并生成一个新的 block
        if (bockStatus || y >= Row_Game_y) {
            //判断是否已到顶部
            if (y <= 0) {
                _gameStatus = GameStatus_Over;
                //停掉计时器
                [_timer invalidate];
                _timer = nil;
            }else {
                [self generateBlock];
            }
            return;

        }
    }
    for (int a = 0;a < 4 ; a++) {
        //先擦除之前的 block
        [self clearBlockSrateWith:_pointCurrBlock[a].x y:_pointCurrBlock[a].y];
    }
    
    for (int i = 0; i < 4; i++) {
        //更新当前block的状态
        _pointCurrBlock[i].y++;
        int x = _pointCurrBlock[i].x;
        int y = _pointCurrBlock[i].y;
        [self updateBlockStateWithType:x y:y i:i];
  
    }
}

- (void)timer:(id)sender
{
    [self downBlock];
}

- (void)updateBlockStateWithType:(int)x y:(int)y i:(int)i
{
    _typeTrixUnit[x][y] = _typeCurrBlock;
    _statusTrixUnit[x][y] = YES;
    if (y >= 0) {
        _imgViewTrixUnit[x][y].image = _imgBlockUnit[_typeCurrBlock];
    }
    CGPoint blockPoint = CGPointMake(x, y);
    _pointCurrBlock[i] = blockPoint;
}

- (void)clearBlockSrateWith:(int)x y:(int)y
{
    _typeTrixUnit[x][y] = BlockType_None;
    _statusTrixUnit[x][y] = NO;
    _imgViewTrixUnit[x][y].image = nil;

}



@end
