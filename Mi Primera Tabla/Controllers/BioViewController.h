//
//  BioViewController.h
//  Mi Primera Tabla
//
//  Created by Ivan on 9/23/17.
//  Copyright © 2017 wondererApps. All rights reserved.
//

#ifndef BioViewController_h
#define BioViewController_h
#import <UIKit/UIKit.h>

#endif /* BioViewController_h */
@interface BioViewController  : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *bioText;
@property (weak, nonatomic) IBOutlet UIImageView *bioImage;
@property NSInteger selectedRow;
@property NSMutableArray *userBios;
@property NSMutableArray *userImages;
@end
