//
//  ViewController.m
//  WebTask
//
//  Created by Aleksandr on 14/12/2019.
//  Copyright © 2019 Aleksandr Shushkov. All rights reserved.
//

#import "ViewController.h"
#import <WebKit/WebKit.h>

@interface ViewController () <WKNavigationDelegate>

@property (weak, nonatomic) IBOutlet WKWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *undo;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *redo;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *activityIndicator;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.title = @"Browser";
    
    self.webView.navigationDelegate = self;
    
    if ([self.address hasPrefix:@"http"] || [self.address hasPrefix:@"HTTP"]) {
        NSURL *url = [[NSURL alloc] initWithString:self.address];
        NSURLRequest *urlRequest = [[NSURLRequest alloc] initWithURL:url];
        [self.webView loadRequest:urlRequest];
    } else if ([self.address hasSuffix:@".pdf"] || [self.address hasSuffix:@".PDF"]) {
        NSURL *url = [[NSBundle mainBundle] URLForResource:self.address withExtension:nil];
        [self.webView loadFileURL:url allowingReadAccessToURL:[url URLByDeletingLastPathComponent]];
    }
}

- (IBAction)undoAction:(UIBarButtonItem *)sender {
    if (self.webView.canGoBack) {
        [self.webView stopLoading];
        [self.webView goBack];
    }
}

- (IBAction)refreshAction:(UIBarButtonItem *)sender {
    [self.webView stopLoading];
    [self.webView reload];
}

- (IBAction)redoAction:(UIBarButtonItem *)sender {
    if (self.webView.canGoForward) {
        [self.webView stopLoading];
        [self.webView goForward];
    }
}

- (void)refreshButtons {
    self.undo.enabled = self.webView.canGoBack;
    self.redo.enabled = self.webView.canGoForward;
}

#pragma mark - WKNavigationDelegate

- (void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation {
    [self.activityIndicator startAnimating];
}

- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    [self.activityIndicator stopAnimating];
    [self refreshButtons];
}

- (void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error {
    [self.activityIndicator stopAnimating];
    [self refreshButtons];
}

@end
