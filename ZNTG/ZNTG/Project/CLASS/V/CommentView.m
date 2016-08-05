//
//  CommentView.m
//  ZNTG
//
//  Created by FeiCao on 16/8/4.
//  Copyright © 2016年 Peter. All rights reserved.
//

#import "CommentView.h"

@implementation CommentView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initializeCommentView];
    }
    return self;
}

- (void)initializeCommentView {
    _commentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    CGFloat margin = kScreenWidthScale(20);
    CGFloat commentButtonHeight = kScreenHeightScale(60);
    CGFloat commentButtonY = (self.height - commentButtonHeight) / 2;
    CGFloat commentButtonWidth = self.width - kScreenWidthScale(140) - margin;
    _commentButton.frame = CGRectMake(margin, commentButtonY, commentButtonWidth, commentButtonHeight);
    _commentButton.layer.cornerRadius = commentButtonHeight / 2;
    _commentButton.layer.masksToBounds = YES;
    _commentButton.layer.borderWidth = 0.5f;
    _commentButton.layer.borderColor = [kCustomColor(200, 200, 200, 1.0) CGColor];
    _commentButton.backgroundColor = [UIColor whiteColor];
    _commentButton.titleLabel.font = [UIFont systemFontOfSize:13];
    _commentButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [_commentButton setTitle:@"    写评论..." forState:UIControlStateNormal];
    [_commentButton setTitleColor:kCustomColor(86, 86, 86, 1) forState:UIControlStateNormal];
    [self addSubview:_commentButton];
    
    _commentRightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    UIImage *commentImage = [UIImage imageNamed:@"xiaoxi"];
    CGFloat commentRightButtonWidth = commentImage.size.width;
    CGFloat commentRightButtonHeight = commentImage.size.height;
    CGFloat commentRightButtonX = _commentButton.right + kScreenWidthScale(44);
    CGFloat commentRightButtonY = (self.height - commentRightButtonHeight) / 2;
    _commentRightButton.frame = CGRectMake(commentRightButtonX, commentRightButtonY, commentRightButtonWidth, commentRightButtonHeight);
    [_commentRightButton setImage:commentImage forState:UIControlStateNormal];
    [self addSubview:_commentRightButton];
    
    UILabel *commentNumber = [[UILabel alloc] initWithFrame:CGRectMake(_commentRightButton.left + kScreenWidthScale(18), _commentRightButton.top - kScreenHeightScale(10) , kScreenWidthScale(54), kScreenHeightScale(20))];
    commentNumber.backgroundColor = kCustomColor(232, 61, 57, 1);
    commentNumber.text = @"89";
    commentNumber.font = [UIFont systemFontOfSize:8];
    commentNumber.textColor = [UIColor whiteColor];
    commentNumber.textAlignment = NSTextAlignmentCenter;
    commentNumber.layer.cornerRadius = kScreenHeightScale(20) / 2;
    commentNumber.layer.masksToBounds = YES;
    [self addSubview:commentNumber];
    
    UILabel *topLine = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.width, 0.5)];
    topLine.backgroundColor = kCustomColor(200, 200, 200, 1.0);
    [self addSubview:topLine];
}

@end
