//
//  BioViewController.m
//  Mi Primera Tabla
//
//  Created by Ivan on 9/23/17.
//  Copyright © 2017 wondererApps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BioViewController.h"

@interface BioViewController ()



@end

@implementation BioViewController

/*userImages = [[NSMutableArray alloc] initWithObjects: @"Tyrion.jpg", @"Danaerys.jpg", @"Eddard.jpg", @"Dragon.jpg", nil];*/

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self initController];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initController {
    self.userBios = [[NSMutableArray alloc] initWithObjects: @"Lord Tyrion Lannister is the youngest child of Lord Tywin Lannister and younger brother of Cersei and Jaime Lannister. A dwarf, he uses his wit and intellect to overcome the prejudice he faces.", @"Queen Daenerys I Targaryen, also known as Dany and Daenerys Stormborn, is the younger sister of Rhaegar Targaryen and Viserys Targaryen, the paternal aunt of Jon Snow, and the youngest child of King Aerys II Targaryen and Queen Rhaella Targaryen, who were both ousted from the Iron Throne during Robert Baratheon's rebellion.", @"Lord Eddard Stark, also known as Ned Stark, was the head of House Stark, the Lord of Winterfell, Lord Paramount and Warden of the North, and later Hand of the King to King Robert I Baratheon. ", @"The last dragon ​belonging to House Targaryen died many decades before Robert's Rebellion. Its death marked the extinction of dragons in Westeros and beyond until the birth of Daenerys Targaryen's dragons.", nil];
    NSString *noBio = @"No biography for this user yet.";
    if (self.selectedRow >= self.userBios.count){
        self.bioText.text = noBio;
    } else {
        self.bioText.text = self.userBios[self.selectedRow];
    }
    self.bioImage.image = self.userImages[self.selectedRow];
}

@end
