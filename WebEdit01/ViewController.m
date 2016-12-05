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
    beginString =@"<html>\n<meta http-equiv='Content-Type' content='text/html; charset=utf-8' />\n<style>\ndiv{\nborder:solid 1px #cccccc;\nbackground-color:white;\nborder-radius:5px;\nbox-shadow: 10px 10px 15px #888888;\npadding:10;}\n</style>\n<body>\n<img src= \nwidth=100%>\n<center>\n<table width=50%>\n<tr><td><div>\na\n</div></td></tr>\n\n</table></center>\n</body>\n</html>";
    htmTags =@[@"<link type=text/css rel=stylesheet href=stil.css>",@"<script src='myscripts.js'></script>", @"color:red;", @"background-color:orange;",
               @"border-radius:10px;", @"border:solid 1px;", @"box-shadow: 10px 10px 5px #888888;", @"<xmp>", @"<script>",@"<table>",@"<td>",@"<tr>",@"<div>",
               @"<svg width='100' height='100' id='svg' style='position:absolute;left:10; top:10;'>",
               @"<rect x=10 y=10 width=100 height=150 style='stroke:#000; fill:brown'/>",
               @"<circle id='circ' cx='60' cy='60' r='40' stroke='orange' stroke-width='4' fill='white'/>",
               @"<canvas id='can' width='500' height='500' style='border:1px solid #000000;'> </canvas>",
               @"ctx=can.getContext('2d')",@"ctx.lineWidth = 0.5",@"ctx.moveTo(xc,yc)",@"ctx.lineTo(x,y)",@"ctx.stroke()",
               @"event.clientX",@"event.clientY",
               @"function",@"document.getElementById()",@"style.transform = 'rotate('+kut+'deg)'",@"style.transformOrigin = '50% 0%'",
               @"t=new Date()",@"t.getSeconds()",@"t.getMinutes()",@"t.getHours()",@"setInterval"];
    htmName =@[@"HTML", @"ExternalCSS", @"Font color", @"Background color", @"Radius", @"Border", @"Shadow", @"Code", @"script link", @"abstract", @"arguments", @"boolean",
               @"break", @"byte", @"case", @"catch", @"char", @"class", @"const", @"continue", @"debugger", @"default", @"delete", @"do", @"double",@"else", @"enum", @"eval", @"export", @"extends", @"false", @"final", @"finally", @"float", @"for", @"function", @"goto", @"if", @"implements", @"import", @"in", @"instanceof", @"int", @"interface", @"let", @"long", @"native", @"new", @"null", @"package", @"private", @"protected", @"public", @"return", @"short", @"static", @"super", @"switch",  @"synchronized", @"this", @"throw", @"throws", @"transient", @"true", @"try", @"typeof", @"var", @"void", @"volatile", @"while", @"with", @"yield", @"Array", @"Date", @"eval", @"function", @"hasOwnProperty", @"Infinity", @"isFinite", @"isNaN", @"isPrototypeOf", @"length", @"Math", @"NaN", @"name", @"Number", @"Object", @"prototype", @"String", @"toString", @"undefined", @"valueOf", @"alert", @"all", @"anchor", @"anchors", @"area", @"assign", @"blur", @"button", @"checkbox", @"clearInterval", @"clearTimeout", @"clientInformation", @"close", @"closed", @"confirm", @"constructor", @"crypto", @"decodeURI", @"decodeURIComponent", @"defaultStatus", @"document",	 @"element", @"elements", @"embed", @"embeds", @"encodeURI", @"encodeURIComponent", @"escape", @"event", @"fileUpload", @"focus", @"form", @"forms", @"frame", @"innerHeight", @"innerWidth", @"layer", @"layers", @"link",	 @"location", @"mimeTypes", @"navigate", @"navigator", @"frames", @"frameRate", @"hidden", @"history", @"image", @"images", @"offscreenBuffering", @"open", @"opener", @"option", @"outerHeight", @"outerWidth", @"packages", @"pageXOffset", @"pageYOffset", @"parent", @"parseFloat", @"parseInt", @"password", @"pkcs11", @"plugin", @"prompt", @"propertyIsEnum", @"radio", @"reset", @"screenX", @"screenY", @"scroll", @"secure", @"select", @"self",	 @"setInterval", @"setTimeout", @"status", @"submit",  @"taint", @"text", @"textarea", @"top", @"unescape", @"untaint", @"window", @"onblur", @"onclick", @"onerror", @"onfocus", @"onkeydown", @"onkeypress", @"onkeyup",  @"onmouseover", @"onload", @"onmouseup", @"onmousedown", @"onsubmit"
               ];
    sintaxString = @[@"{",@"}"];
    [_sTextView setFont:[NSFont fontWithName:@"Menlo" size:14]];
    [self.tableView setDoubleAction:@selector(clickDouble)];
    beginWith = [NSArray arrayWithArray:htmTags];
    _sTextView.delegate = self;
    _filterText.delegate = self;
    
}
- (IBAction)resetStyle:(id)sender {
    [_sTextView setFont:[NSFont fontWithName:@"Menlo" size:14]];
    [_sTextView setTextColor:[NSColor blackColor]];
    [_sTextView setBackgroundColor:[NSColor whiteColor]];
}

- (BOOL)textView:(NSTextView *)textView shouldChangeTextInRange:(NSRange)affectedCharRange replacementString:(NSString *)replacementString{
    
    NSString *selected = [[textView string] substringWithRange:[textView selectedRange]];
    NSLog(@"change3:%ld %@",affectedCharRange.location,selected);
    
    return YES;
}
//text field change
- (void)controlTextDidChange:(NSNotification *)notification {
    NSTextField *textField = [notification object];
    NSString *filterString = [textField stringValue];
    if (filterString.length>0) {
        void(^filterBlock)(void) = ^{
            NSPredicate *cPredicate = [NSPredicate predicateWithFormat:@"SELF beginswith[c] %@",filterString];
            beginWith = [htmTags filteredArrayUsingPredicate:cPredicate];
            [_tableView reloadData];
        };
        filterBlock();
    } else {
        beginWith = [NSArray arrayWithArray:htmTags];
        [_tableView reloadData];
    }
    
    NSLog(@"gkjhg");
}

- (void) textDidChange: (NSNotification *) notification {
    NSLog(@"change1");
    //[self oznaciSubstring];
    
}
- (IBAction)selectSubstring:(id)sender {
    int length = (int)[_sTextView.string length];
    for (NSString *string in sintaxString)  {
        NSRange range = NSMakeRange(0, length);
        while(range.location != NSNotFound){
            range = [_sTextView.string rangeOfString: string options:0 range:range];
            if(range.location != NSNotFound) {
                [_sTextView setTextColor:[NSColor redColor] range:range];
                range = NSMakeRange(range.location + range.length, length - (range.location + range.length));
            }
        }
    }

}

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

//table view double click
- (void)clickDouble{
    NSRange range = _sTextView.rangeForUserTextChange;
    [_sTextView insertText:[beginWith objectAtIndex:_tableView.selectedRow] replacementRange:range];
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
- (IBAction)insertHtml:(id)sender {
    NSRange range = _sTextView.rangeForUserTextChange;
    [_sTextView insertText:beginString replacementRange:range];
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
    result.textField.stringValue = [beginWith objectAtIndex:row];
    
    // Return the result
    return result;
}
- (NSInteger)numberOfRowsInTableView:(NSTableView *)tableView {
    return beginWith.count;
}


@end
