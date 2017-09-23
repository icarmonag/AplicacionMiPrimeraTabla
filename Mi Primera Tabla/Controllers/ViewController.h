//
//  ViewController.h
//  Mi Primera Tabla
//
//  Created by Ivan on 9/20/17.
//  Copyright © 2017 wondererApps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController  : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tblMain;

@property (strong, nonatomic) IBOutlet UIImageView *imageView;

- (IBAction)takePhoto:  (UIButton *)sender;
- (IBAction)selectPhoto:(UIButton *)sender;

@end

