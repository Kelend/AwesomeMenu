//
//  AwesomeMenuItem.h
//  AwesomeMenu
//
//  Created by Levey on 11/30/11.
//  Copyright (c) 2011 Levey & Other Contributors. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AwesomeMenu;
@protocol AwesomeMenuItemDelegate;

@interface AwesomeMenuItem : UIImageView

@property (nonatomic, strong) UIImageView *contentImageView;
@property (nonatomic, weak) UILabel *textLabel;

@property (nonatomic) CGPoint startPoint;
@property (nonatomic) CGPoint endPoint;
@property (nonatomic) CGPoint nearPoint;
@property (nonatomic) CGPoint farPoint;

@property (nonatomic, weak) id<AwesomeMenuItemDelegate> delegate;

- (id)initWithImage:(UIImage *)img
   highlightedImage:(UIImage *)himg
       ContentImage:(UIImage *)cimg
highlightedContentImage:(UIImage *)hcimg
               text:(NSString *)text;

- (id)initWithImage:(UIImage *)img
   highlightedImage:(UIImage *)himg
       ContentImage:(UIImage *)cimg
highlightedContentImage:(UIImage *)hcimg;

- (void)awesomeMenuDidOpen:(AwesomeMenu *)awesomeMenu;
- (void)awesomeMenuDidClose:(AwesomeMenu *)awesomeMenu;
- (void)awesomeMenuWillOpen:(AwesomeMenu *)awesomeMenu;
- (void)awesomeMenuWillClose:(AwesomeMenu *)awesomeMenu;

@end

@protocol AwesomeMenuItemDelegate <NSObject>
- (void)AwesomeMenuItemTouchesBegan:(AwesomeMenuItem *)item;
- (void)AwesomeMenuItemTouchesEnd:(AwesomeMenuItem *)item;
@end