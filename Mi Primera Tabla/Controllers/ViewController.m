//
//  ViewController.m
//  Mi Primera Tabla
//
//  Created by Ivan on 9/20/17.
//  Copyright © 2017 wondererApps. All rights reserved.
//

#import "ViewController.h"
#import "cellMainTable.h"
#import "AVFoundation/AVFoundation.h"
#import "Photos/Photos.h"


@interface ViewController ()
@property NSMutableArray *userNames;
@property NSMutableArray *userAges;
@property NSMutableArray *userImages;
@property NSMutableArray *imageTaken;
@property UITextField *textField1;
@property UITextField *textField2;
@end

@implementation ViewController

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
    self.userNames = [[NSMutableArray alloc] initWithObjects: @"Tyrion Lannister", @"Danaerys Targaryen", @"Eddard Stark", @"Dragon", nil];
    self.userAges = [[NSMutableArray alloc] initWithObjects: @"Edad: 38 años", @"Edad: 18 años", @"Edad: 48 años", @"Edad: 1000 años", nil];
    self.userImages = [[NSMutableArray alloc] initWithObjects: @"Tyrion.jpg", @"Danaerys.jpg", @"Eddard.jpg", @"Dragon.jpg", nil];
    self.imageTaken = [[NSMutableArray alloc] initWithObjects: @"Tyrion.jpg", @"Danaerys.jpg", @"Eddard.jpg", @"Dragon.jpg", nil];
    NSLog(@"%@", @"Camera access not determined. Ask for permission.");
    
    [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
        if(granted){
            NSLog(@"Granted access to %@", AVMediaTypeVideo);
        } else {
            NSLog(@"Not granted access to %@", AVMediaTypeVideo);
        }
    }];
    [PHPhotoLibrary requestAuthorization:^(PHAuthorizationStatus status) {
        if (status != PHAuthorizationStatusAuthorized)
        {
            //User don't give us permission. Showing alert with redirection to settings
            //Getting description string from info.plist file
            NSString *accessDescription = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSPhotoLibraryUsageDescription"];
            UIAlertController * alertController = [UIAlertController alertControllerWithTitle:accessDescription message:@"To give permissions tap on 'Change Settings' button" preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
            [alertController addAction:cancelAction];
            
            UIAlertAction *settingsAction = [UIAlertAction actionWithTitle:@"Change Settings" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
            }];
            [alertController addAction:settingsAction];
            
            [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:alertController animated:YES completion:nil];
        }
    }];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
//-------------------------------------------------------------------------------
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.userNames.count;
}
//-------------------------------------------------------------------------------
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 64;
}
//-------------------------------------------------------------------------------
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //Initialize cells
    cellMainTable *cell = (cellMainTable *)[tableView dequeueReusableCellWithIdentifier:@"cellMainTable"];
    
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"cellMainTable" bundle:nil] forCellReuseIdentifier:@"cellMainTable"];
        cell = [tableView dequeueReusableCellWithIdentifier:@"cellMainTable"];
    }
    //Fill cell with info from arrays
    cell.lblName.text       = self.userNames[indexPath.row];
    cell.lblAge.text        = self.userAges[indexPath.row];
    if ([self.userImages[indexPath.row] isEqualToString:@"taken"]){
        cell.image.image      = self.imageTaken[indexPath.row];
    } else {
        cell.image.image      = [UIImage imageNamed:self.userImages[indexPath.row]];
    }
    
    return cell;
}

- (IBAction)addUser:(id)sender {
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 250, 75)];
    
    self.textField1 = [[UITextField alloc] initWithFrame:CGRectMake(10,0,252,25)];
    self.textField1.borderStyle = UITextBorderStyleRoundedRect;
    self.textField1.placeholder = @"Enter Name";
    self.textField1.keyboardAppearance = UIKeyboardAppearanceAlert;
    self.textField1.delegate = nil;
    [v addSubview:self.textField1];
    
    self.textField2 = [[UITextField alloc] initWithFrame:CGRectMake(10,30,252,25)];
    self.textField2.placeholder = @"Enter Age";
    self.textField2.borderStyle = UITextBorderStyleRoundedRect;
    self.textField2.keyboardAppearance = UIKeyboardAppearanceAlert;
    self.textField2.delegate = nil;
    [v addSubview:self.textField2];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Nuevo usuario" message:@"Ingresar nombre y edad." delegate:self cancelButtonTitle:@"Cancelar" otherButtonTitles:@"Agregar", nil];
    
    [alert setValue:v  forKey:@"accessoryView"];
    [alert show];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [self selectPhoto ];
        [self.userNames addObject:self.textField1.text];
        NSString *age =[ NSString stringWithFormat:@"Edad: %@ años", self.textField2.text];
        [self.userAges addObject:age];
        
    }
    if (buttonIndex == 2)
    {
        [self takePhoto ];
        //Boton cancelar
    }
}

- (void)takePhoto {

    
    if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        
        UIAlertView *myAlertView = [[UIAlertView alloc] initWithTitle:@"Error"
                                                              message:@"Device has no camera"
                                                             delegate:nil
                                                    cancelButtonTitle:@"OK"
                                                    otherButtonTitles: nil];
        
        [myAlertView show];
        
    } else {
    
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        
        [self presentViewController:picker animated:YES completion:NULL];
        
    }
    
}

- (void)selectPhoto {
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    
    [self presentViewController:picker animated:YES completion:NULL];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.imageView.image = chosenImage;
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    [self.userImages addObject:@"taken"];
    [self.imageTaken addObject:chosenImage];
    [self.tblMain reloadData];
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    
    [picker dismissViewControllerAnimated:YES completion:NULL];
    
}

- (IBAction)unwindBioAction:(UIStoryboardSegue *)segue {
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self performSegueWithIdentifier:@"showBioSegue" sender:indexPath];
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([segue.identifier isEqualToString:@"showBioSegue"])
    {
        
        NSIndexPath *indexPath = (NSIndexPath *)sender;
        BioViewController *destViewController = segue.destinationViewController;
        destViewController.selectedRow = indexPath.row;
        for (int i=0;i<self.userImages.count;i++){
            if (i==0){
                destViewController.userImages = [[NSMutableArray alloc] initWithObjects: @"Tyrion.jpg", @"Danaerys.jpg", @"Eddard.jpg", @"Dragon.jpg", nil];
            }
            
            if (i>=destViewController.userImages.count)
            {
                [destViewController.userImages addObject:self.imageTaken[i]];
            } else {
                destViewController.userImages[i]=[UIImage imageNamed:self.userImages[i]];
            }
        }
    }
}
@end

