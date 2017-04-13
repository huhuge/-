//
//  HHIconView.m
//  嗨微博
//
//  Created by 胡明正 on 2017/4/12.
//  Copyright © 2017年 huhuge. All rights reserved.
//

#import "HHIconView.h"
#import "HHUser.h"

@interface HHIconView()
@property (nonatomic, weak) UIImageView *verifiedView;

@end

@implementation HHIconView

- (UIImageView *)verifiedView{
    if (!_verifiedView) {
        
       UIImageView *verifiedView = [[UIImageView alloc] init];
        [self addSubview:verifiedView];
        self.verifiedView = verifiedView;
    }
    return _verifiedView;
}


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
//        self.layer.masksToBounds = YES;
//        self.layer.cornerRadius = 35 / 2;
//        self.layer.borderColor = HHRGBColor(247, 247, 247).CGColor;
//        self.layer.borderWidth = 0.5;
    }
    return self;
}

- (void)setUser:(HHUser *)user{
    _user = user;
    
    // 1.下载图片
    [self sd_setImageWithURL:[NSURL URLWithString:user.profile_image_url] placeholderImage:[UIImage imageNamed:@"avatar_default_small"]];
    
    // 2.加V
    /*
     HHUserVerifiedTypeNone      = -1, // 没有任何认证
     HHUserVerifiedPersonal      = 0,  // 个人认证
     HHUserVerifiedOrgEnterprice = 2,  // 企业官方：CSDN、EOE、搜狐新闻客户端
     HHUserVerifiedOrgMedia      = 3,  // 媒体官方：程序员杂志、苹果汇
     HHUserVerifiedOrgWebsite    = 5,  // 网站官方：猫扑
     HHUserVerifiedDaren         = 220 // 微博达人

     */
    switch (user.verified_type) {
        case HHUserVerifiedPersonal:
        {
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_vip"];
        }
            break;
            
        case HHUserVerifiedOrgEnterprice:
        case HHUserVerifiedOrgMedia:
        case HHUserVerifiedOrgWebsite:
        {
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_enterprise_vip"];

        }
            break;
            
        case HHUserVerifiedDaren:
        {
            self.verifiedView.hidden = NO;
            self.verifiedView.image = [UIImage imageNamed:@"avatar_grassroot"];
        }
            break;
            
        default:
            self.verifiedView.hidden = YES;
            break;
    }
}

- (void)layoutSubviews{
    self.verifiedView.size = self.verifiedView.image.size;
    CGFloat scale = 0.6;
    self.verifiedView.x = self.width - self.verifiedView.width * scale;
    self.verifiedView.y = self.height - self.verifiedView.height * scale;
}


@end
