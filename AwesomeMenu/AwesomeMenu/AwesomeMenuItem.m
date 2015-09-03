//
//  AwesomeMenuItem.m
//  AwesomeMenu
//
//  Created by Levey on 11/30/11.
//  Copyright (c) 2011 Levey & Other Contributors. All rights reserved.
//

#import "AwesomeMenuItem.h"
static inline CGRect ScaleRect(CGRect rect, float n) {return CGRectMake((rect.size.width - rect.size.width * n)/ 2, (rect.size.height - rect.size.height * n) / 2, rect.size.width * n, rect.size.height * n);}

@implementation AwesomeMenuItem

#pragma mark - initialization & cleaning up
- (id)initWithImage:(UIImage *)img
   highlightedImage:(UIImage *)himg
       ContentImage:(UIImage *)cimg
highlightedContentImage:(UIImage *)hcimg
{
    return [self initWithImage:img highlightedImage:himg ContentImage:cimg highlightedContentImage:hcimg text:nil];
}

- (id)initWithImage:(UIImage *)img 
   highlightedImage:(UIImage *)himg
       ContentImage:(UIImage *)cimg
highlightedContentImage:(UIImage *)hcimg
               text:(NSString *)text
{
    if (self = [super init]) {
        self.backgroundColor = [UIColor clearColor];
        self.image = img;
        self.highlightedImage = himg;
        self.userInteractionEnabled = YES;

        UIImageView *contentImageView = [[UIImageView alloc] initWithImage:cimg];
        contentImageView.translatesAutoresizingMaskIntoConstraints = NO;
        contentImageView.highlightedImage = hcimg;
        [contentImageView setContentHuggingPriority:UILayoutPriorityDefaultHigh forAxis:UILayoutConstraintAxisHorizontal];
        [self addSubview:contentImageView];
        self.contentImageView = contentImageView;
        
        UILabel *textLabel = [[UILabel alloc] init];
        textLabel.translatesAutoresizingMaskIntoConstraints = NO;
        textLabel.textColor = [UIColor blueColor];
        textLabel.text = text;
        [self addSubview:textLabel];
        self.textLabel = textLabel;
        
        NSDictionary *views = NSDictionaryOfVariableBindings(contentImageView, textLabel);
        NSDictionary *metrics = @{ };
        
        if (text.length > 0) {
            [self addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:[textLabel]-10-[contentImageView]|" options:0 metrics:metrics views:views]];
            [self addConstraint:[NSLayoutConstraint constraintWithItem:textLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.0f]];
        }

        [self addConstraint:[NSLayoutConstraint constraintWithItem:contentImageView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f]];
        [self addConstraint:[NSLayoutConstraint constraintWithItem:contentImageView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.0f]];
        
        [self sizeToFit];
    }
    return self;
}

#pragma mark - UIView's methods

- (CGSize)sizeThatFits:(CGSize)size
{
    return CGSizeMake(self.image.size.width, self.image.size.height);
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.highlighted = YES;
    if ([self.delegate respondsToSelector:@selector(AwesomeMenuItemTouchesBegan:)]) {
       [self.delegate AwesomeMenuItemTouchesBegan:self];
    }
    
}
- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    // if move out of 2x rect, cancel highlighted.
    CGPoint location = [[touches anyObject] locationInView:self];
    if (!CGRectContainsPoint(ScaleRect(self.bounds, 2.0f), location)) {
        self.highlighted = NO;
    }
    
}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.highlighted = NO;
    // if stop in the area of 2x rect, response to the touches event.
    CGPoint location = [[touches anyObject] locationInView:self];
    if (CGRectContainsPoint(ScaleRect(self.bounds, 2.0f), location)) {
        if ([self.delegate respondsToSelector:@selector(AwesomeMenuItemTouchesEnd:)]) {
            [self.delegate AwesomeMenuItemTouchesEnd:self];
        }
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.highlighted = NO;
}

#pragma mark - instant methods
- (void)setHighlighted:(BOOL)highlighted
{
    [super setHighlighted:highlighted];
    [self.contentImageView setHighlighted:highlighted];
}

- (void)awesomeMenuDidOpen:(AwesomeMenu *)awesomeMenu
{
    //Abstract
}

- (void)awesomeMenuDidClose:(AwesomeMenu *)awesomeMenu
{
    //Abstract
}

- (void)awesomeMenuWillOpen:(AwesomeMenu *)awesomeMenu
{
    //Abstract
}

- (void)awesomeMenuWillClose:(AwesomeMenu *)awesomeMenu
{
    //Abstract
}

@end
