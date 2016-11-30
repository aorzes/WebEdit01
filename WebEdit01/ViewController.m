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
               @"box-shadow: 10px 10px 5px #888888;"];
    htmName =@[@"HTML",
               @"Font color",
               @"Background color",
               @"Radius",
               @"Border",
               @"Shadow"];
    [_sTextView setFont:[NSFont fontWithName:@"Menlo" size:14]];
    [self.tableView setDoubleAction:@selector(clickDouble)];
    
}

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
