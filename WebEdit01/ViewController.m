//
//  ViewController.m
//  WebEdit01
//
//  Created by Anton Orzes on 29/11/2016.
//  Copyright © 2016 Anton Orzes. All rights reserved.
//

#import "ViewController.h"

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    NSString *beginString =@"<html>\n<style>\ndiv{\nborder:solid 1px #cccccc;\nbackground-color:white;\nborder-radius:5px;\nbox-shadow: 10px 10px 15px #888888;\npadding:10;}\n</style>\n<body>\n<img src= \nwidth=100%>\n<center>\n<table width=50%>\n<tr><td><div>\na\n</div></td></tr>\n\n</table></center>\n</body>\n</html>";
    htmTags =@[beginString,
               @"color:red;",
               @"background-color:orange;",
               @"border-radius:10px;",
               @"border:solid 1px;",
               @"box-shadow: 10px 10px 5px #888888;",
               @"<xmp>"];
    htmName =@[@"HTML",
               @"Font color",
               @"Background color",
               @"Radius",
               @"Border",
               @"Shadow",
               @"Code"];
    [_sTextView setFont:[NSFont fontWithName:@"Menlo" size:14]];
    [self.tableView setDoubleAction:@selector(clickDouble)];
    _sTextView.delegate = self;
    
}

//- (BOOL)textView:(NSTextView *)textView shouldChangeTextInRange:(NSRange)affectedCharRange replacementString:(NSString *)replacementString{
//    NSLog(@"change3:%ld",affectedCharRange.location);
//    NSString *selected = [[textView string] substringWithRange:[textView selectedRange]];
//    
//    return YES;
//}

//- (void) textDidChange: (NSNotification *) notification {
//    NSLog(@"change1");
//}

//- (void)textViewDidChangeSelection:(NSNotification *)notification{
//    NSLog(@"change4");
//}

//- (NSRange)textView:(NSTextView *)textView willChangeSelectionFromCharacterRange:(NSRange)oldSelectedCharRange toCharacterRange:(NSRange)newSelectedCharRange{
//    //NSString *selectedString = [textView.string substringWithRange:newSelectedCharRange];
//    //NSString *string = textView.string;
//    NSRange newRange = newSelectedCharRange;
//    NSString *selected = [textView.string substringWithRange:newRange];
//    NSLog(@"%@",selected);
//    newRange.location += newRange.length;
//    newRange.length = textView.string.length - newSelectedCharRange.location;
//    
//    //_sTextView.selectedRanges = newRange.length;
//    //if (newRange.length>0 && newRange.location>0) {
//    
////    NSWindow *nWindow =  textView.window;
////    NSText* textEditor = [nWindow fieldEditor:YES forObject:textView];
////    [textEditor setSelectedRange:newRange];
//    
//    //[textView showFindIndicatorForRange:newRange];
//    NSLog(@"%lu",(unsigned long)newRange.length);
//    [textView setTextColor:[NSColor redColor] range:newSelectedCharRange];
//    return newSelectedCharRange;
//}

//table view
- (void)clickDouble{
    NSRange range = _sTextView.rangeForUserTextChange;
    [_sTextView insertText:[htmTags objectAtIndex:_tableView.selectedRow] replacementRange:range];
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

- (IBAction)saveDocument:(id)sender {
    NSLog(@"save document");
    NSString *str = _sTextView.string;
    if (pathString!=NULL) {
        [str writeToFile:pathString atomically:YES encoding:NSUTF8StringEncoding error:nil];
    }
}

- (IBAction)saveDocumentAs:(id)sender {
    NSString *newName=@"untitWeb.htm";
    NSSavePanel *panel = [NSSavePanel savePanel];
    [panel setNameFieldStringValue:newName];
    [panel beginWithCompletionHandler:^(NSInteger result){
        if (result == NSFileHandlingPanelOKButton){
            pathString = panel.URL.path;
            NSString *str = _sTextView.string;
            if (pathString!=NULL) {
                [str writeToFile:pathString atomically:YES encoding:NSUTF8StringEncoding error:nil];
            }
        }
    }];

}

- (IBAction)openExistingDocument:(id)sender {
    NSOpenPanel* panel = [NSOpenPanel openPanel];
    NSLog(@"open se pokree kada se klikne na open");
    // povuce se podizbornik na crvenu kockicu i izabere metoda koja je prethodno napisana
    [panel beginWithCompletionHandler:^(NSInteger result){
        if (result == NSFileHandlingPanelOKButton) {
            path = [[panel URLs] objectAtIndex:0];
            //panel.directoryURL
            NSLog(@"Open  the document %@",panel.URL.path);
            // Open  the document.
            NSError *error = nil;
            NSString *mySting = [[NSString alloc] initWithContentsOfURL:path
                                                               encoding:NSUTF8StringEncoding
                                                                  error:&error];
            pathString = panel.URL.path;
            _sTextView.string = mySting;
            
        }
    }];
}

- (IBAction)ucitaj:(id)sender {
    if (pathString==NULL) {
        NSString *str = _sTextView.string;
        [[_webView mainFrame] loadHTMLString:str baseURL:nil];
    }
    NSURL *url = [NSURL URLWithString:pathString];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    [[_webView mainFrame] loadRequest:urlRequest];
}

- (IBAction)ucitajFromText:(id)sender {
    NSString *str = _sTextView.string;
    [[_webView mainFrame] loadHTMLString:str baseURL:nil];
}

- (IBAction)insertDivStyle:(id)sender {
    NSRange range = _sTextView.rangeForUserTextChange;
    NSString *newString =@"<tr><td><div>\na\n</div></td></tr>\n";
    [_sTextView insertText:newString replacementRange:range];
}

- (IBAction)insertBegins:(id)sender {
    NSRange range = _sTextView.rangeForUserTextChange;
    [_sTextView insertText:[htmTags objectAtIndex:0] replacementRange:range];
}

- (NSView *)tableView:(NSTableView *)tableView
   viewForTableColumn:(NSTableColumn *)tableColumn
                  row:(NSInteger)row {
    
    NSTableCellView *result = [tableView makeViewWithIdentifier:@"MyCell" owner:self];
    result.textField.stringValue = [htmName objectAtIndex:row];
    
    // Return the result
    return result;
}
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return htmName.count;
}


@end
