/* 
   character histogram

   Copyright 2006-2021 by Alex Myczko <alex@aiei.ch>

   macos: clang -framework Foundation -framework AppKit ch.m -o ch

   Released under the GNU GPL
*/
 
#import <AppKit/AppKit.h>
#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define VERSION "1.0"
#define BS 1
#define CS 256

long long cc[CS];
long long totalsize=0,unused=0;
FILE *f;
int i,j,parameters,average=0;
long r=1;
unsigned char buffer[BS];

@interface HistogramView : NSView
{
}
- (void)drawRect:(NSRect)rect;
@end

@implementation HistogramView

- (void)drawRect:(NSRect)rect
{
    int f;

    srand(0);
    float width = [self bounds].size.width;
    float height = [self bounds].size.height;
    //printf("Width %f\n",width);
    //printf("Height %f\n",height);

    [[NSColor blackColor] set];
    NSRectFill([self bounds]);

    for (f=0; f<256; f++) {
        [[NSColor colorWithDeviceHue:(1.0/256*f) saturation:1.0 brightness:1.0 alpha:1.0] set];
        NSPoint p1 = NSMakePoint(1+f*2,0);
        //NSPoint p2 = NSMakePoint(f,100.0*rand()/(RAND_MAX+1.0));
        NSPoint p2 = NSMakePoint(1+f*2,100.0*cc[f]/totalsize);
        average+=100.0*cc[f]/totalsize;
        [NSBezierPath strokeLineFromPoint:p1 toPoint:p2];
        //printf("%d %ld\n",f,cc[f]);
    }
    average/=256;
    [[NSColor colorWithDeviceHue:(0.5) saturation:0 brightness:1.0 alpha:0.333] set];
    NSPoint p1 = NSMakePoint(0,average);
    NSPoint p2 = NSMakePoint(width,average);
    [NSBezierPath strokeLineFromPoint:p1 toPoint:p2];
}

-(void)openDocument:(NSNotification *)notification
{
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    [panel setCanChooseDirectories:NO];
    [panel setPrompt:@"Choose File"];
    [panel runModalForDirectory:nil file:nil types:nil];
    [self readFile:[panel filename]];
}

- (void)readFile:(NSString *)filePath;
{
    for (i=0; i<CS; i++)
        cc[i]=0;

    printf("Processing %s\n",[filePath cString]);
    f=fopen([filePath cString],"rb");
    fseek(f, 0L, SEEK_END);
    printf("    Size: %ld\n",ftell(f));
    rewind(f);
    while (r!=0) {
        r=fread(buffer, BS, sizeof(char), f);
        for (j=0; j<r; j++) {
            cc[buffer[j]]++;
        }
    }
    r=1;
    fclose(f);

    totalsize=0;
    for (i=0; i<CS; i++) {
        if (cc[i]==0) unused++;
        if (cc[i]>totalsize) totalsize=cc[i];
        //if (i<CS-1) average+=cc[i+1]-cc[i];
    }

    //average-=totalsize;
    //average/=256;
    printf("    Most used character: %lld\n",totalsize);
    printf("    Unused characters: %lld\n",unused);
    unused=0;
    [self display];
}

-(BOOL)applicationShouldTerminateAfterLastWindowClosed:(NSApplication *)theApplication
{
    return YES;
}
@end

void setup()
{
    NSWindow *myWindow;
    NSView   *myView;
    NSRect    graphicsRect;
    
    graphicsRect = NSMakeRect(100.0, 200.0, 513.0, 100.0);

    myWindow = [ [NSWindow alloc]
               initWithContentRect: graphicsRect
                         styleMask:NSTitledWindowMask
                                  |NSClosableWindowMask
                                  |NSMiniaturizableWindowMask
                           backing:NSBackingStoreBuffered
                             defer:NO ];

    [myWindow setTitle:@"Character Histogram"];
    
    myView = [[[HistogramView alloc] initWithFrame:graphicsRect] autorelease];
    
    [myWindow setContentView:myView];
    
    [myWindow setDelegate:myView];
    [myWindow makeKeyAndOrderFront: nil];
}

int main(int argc, char** argv)
{
    NSMenu *mainMenu;
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    NSApp = [NSApplication sharedApplication];
    mainMenu = [[NSMenu new]autorelease];

    if ((argc==1) || (strstr(argv[1],"-h"))) {
        printf("Usage: %s [FILE]...\n",argv[0]);
        printf("Show character histogram of each FILE.\n");
        return 0;
    }

    if (strstr(argv[1],"-v")) {
        printf("Version %s compiled on %s at %s.\n",VERSION,__DATE__,__TIME__);
        return 0;
    }

    for (i=0; i<CS; i++)
        cc[i]=0;

    for (parameters=1; parameters<argc; parameters++) {
        //printf("Processing %s ",argv[parameters]);
        f=fopen(argv[parameters],"rb");
        fseek(f, 0L, SEEK_END);
        //printf("%d\n",ftell(f));
        //totalsize+=ftell(f);
        rewind(f);
        while (r!=0) {
            r=fread(buffer, BS, sizeof(char), f);
            for (j=0; j<r; j++) {
                cc[buffer[j]]++;
            }
        }
        r=1;
        fclose(f);
    }

    for (i=0; i<CS; i++)
        if (cc[i]>totalsize) totalsize=cc[i];

    [mainMenu addItemWithTitle: @"Info..."
                                  action: @selector (orderFrontStandardInfoPanel:)
                                  keyEquivalent: @""];
    [mainMenu addItemWithTitle: @"Open"
                            action: @selector (openDocument:)
                     keyEquivalent: @"o"];
    [mainMenu addItemWithTitle: @"Hide"
                            action: @selector (hide:)
                     keyEquivalent: @"h"];
    [mainMenu addItemWithTitle: @"Quit"
                         action: @selector (terminate:)
                          keyEquivalent: @"q"];

    [NSApp setMainMenu: mainMenu];
    [mainMenu setTitle: @"Character Histogram"];
    
    setup();
    
    [NSApp run];
    
    [NSApp release];
    [pool release];
    return(EXIT_SUCCESS);
}
