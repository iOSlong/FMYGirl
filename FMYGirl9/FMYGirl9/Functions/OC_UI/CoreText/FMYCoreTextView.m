//
//  FMYCoreTextView.m
//  FMYGirl9
//
//  Created by xuewu.long on 17/4/6.
//  Copyright © 2017年 fmy.long. All rights reserved.
//

#import "FMYCoreTextView.h"
#import <CoreText/CoreText.h>

@implementation FMYCoreTextView

- (void)drawRect:(CGRect)rect {
    // Drawing code
    [super drawRect:rect];
    if (self.showText) {
        [self showHelloWold];
    }
}

- (void)showHelloWold {
    // 步骤 1
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // 步骤 2
    CGContextSetTextMatrix(context, CGAffineTransformIdentity);
    CGContextTranslateCTM(context, 0, self.bounds.size.height);
    CGContextScaleCTM(context, 1.0, -1.0);
    
    // 步骤 3
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, self.bounds);
    
    // 步骤 4
    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:self.showText];
    CTFramesetterRef framesetter =
    CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attString);
    CTFrameRef frame =
    CTFramesetterCreateFrame(framesetter,
                             CFRangeMake(0, [attString length]), path, NULL);
    
    // 步骤 5
    CTFrameDraw(frame, context);
    
    // 步骤 6
    CFRelease(frame);
    CFRelease(path);
    CFRelease(framesetter);
}

- (void)setShowText:(NSString *)showText {
    _showText = showText;
    if (showText) {
        [self setNeedsDisplay];
    }
}

@end
