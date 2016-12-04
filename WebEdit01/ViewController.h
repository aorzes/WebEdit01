//
//  ViewController.h
//  WebEdit01
//
//  Created by Anton Orzes on 29/11/2016.
//  Copyright © 2016 Anton Orzes. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import <WebKit/WebKit.h>

@interface ViewController : NSViewController<NSBrowserDelegate,NSTextViewDelegate,NSTextFieldDelegate>
{
    NSURL*  path;
    NSString *pathString;
    NSArray *htmTags;
    NSArray *htmName;
    NSArray *sintaxString;
    NSArray *beginWith;
}
@property (weak) IBOutlet NSScrollView *textScroll;
@property (unsafe_unretained) IBOutlet NSTextView *sTextView;
@property (weak) IBOutlet WebView *webView;
@property (weak) IBOutlet NSTableView *tableView;
@property (weak) IBOutlet NSTextField *filterText;


@end

