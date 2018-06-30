//
//  MenuViewController.m
//  AppPrefeitura
//
//  Created by Marcos Rivereto on 8/14/15.
//  Copyright (c) 2015 BISolutions. All rights reserved.
//

#import "MenuViewController.h"
#import "CityService.h"
#import "MenuTableViewCell.h"
#import "SecretaryServiceViewController.h"
#import "MenuService.h"
#import "Menu.h"

@interface MenuViewController ()

-(void)buildTable;
-(void)buildCollection;
-(void)callSegue:(Menu *)menu;

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) UIImageView *bgView;

@end

@implementation MenuViewController

@synthesize collectionView, tableView, btnChange;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Navigation bar
    NSDictionary *city = [[[CityService alloc]init]getCity];
    
    UIImage *image = [UIImage imageNamed:@"navBarBg"];
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar
     setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    self.title = [city valueForKey:@"name"];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@" " style:UIBarButtonItemStyleBordered target:nil action:nil];
    
    self.navigationItem.backBarButtonItem = backButton;
    
    UIImage *background = [UIImage imageNamed:@"menuBg"];
    self.bgView = [[UIImageView alloc] initWithImage:background];
    
    self.dataArray = [MenuService getMenu];
    
    // Adjust the size of collection and table view
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self buildCollection];
    self.view = self.collectionView;
    
}

#pragma mark private methods
-(void) buildCollection{
    if(!self.collectionView){
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        [flowLayout setItemSize:CGSizeMake(150, 150)];
        [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
        
        self.collectionView = [[UICollectionView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame] collectionViewLayout:flowLayout];
        self.collectionView.delegate = self;
        self.collectionView.dataSource = self;
        
        UINib *cellNib = [UINib nibWithNibName:@"NibCell" bundle:nil];
        [self.collectionView registerNib:cellNib forCellWithReuseIdentifier:@"cvCell"];
        
        [self.collectionView setBackgroundView:self.bgView];
    }
    
    [self.collectionView reloadData];
}

-(void) buildTable{
    if(!self.tableView){
        self.tableView = [[UITableView alloc] initWithFrame:[[UIScreen mainScreen] applicationFrame] style:UITableViewStylePlain];
        self.tableView.autoresizingMask = UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        [self.tableView setBackgroundView:self.bgView];
    }
    
    [self.tableView reloadData];
}

-(void)callSegue:(Menu *)menu{
    NSString *name = [menu name];

    if([name isEqualToString:@"news"]){
        [self performSegueWithIdentifier:@"newsSegue" sender:self];
        
    }else if([name isEqualToString:@"events"]){
        [self performSegueWithIdentifier:@"eventsSegue" sender:self];
        
    }else if([name isEqualToString:@"jobs"]){
        [self performSegueWithIdentifier:@"jobsSegue" sender:self];
        
    }else if([name isEqualToString:@"phones"]){
        [self performSegueWithIdentifier:@"phoneSegue" sender:self];
        
    }else if([name isEqualToString:@"turism"]){
        [self performSegueWithIdentifier:@"turismSegue" sender:self];
        
    }else if([name isEqualToString:@"weather"]){
        [self performSegueWithIdentifier:@"weatherSegue" sender:self];
        
    }else if([name isEqualToString:@"history"]){
        [self performSegueWithIdentifier:@"historySegue" sender:self];
        
    }else if([name isEqualToString:@"about"]){
        [self performSegueWithIdentifier:@"aboutSegue" sender:self];
        
    }else{
        [self performSegueWithIdentifier:@"SecretarySegue" sender:menu];
    }
}

#pragma mark IBActions
-(IBAction)changeView:(UIButton *)sender{
    UIView *fromView, *toView;
    
    if(self.view == self.tableView){
        fromView = self.tableView;
        toView = self.collectionView;
        [self.btnChange setImage:[UIImage imageNamed:@"iconMenuList"]];
    }else{
        [self buildTable];
        fromView = self.collectionView;
        toView = self.tableView;
        [self.btnChange setImage:[UIImage imageNamed:@"iconMenuCollection"]];
    }
    
    self.view = toView;
    
    [UIView transitionFromView:fromView
                        toView:toView
                      duration:0.25
                       options:UIViewAnimationOptionCurveEaseInOut
                    completion:nil];
    
}

#pragma mark <UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.dataArray count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"MenuCell";
    MenuTableViewCell *cell = (MenuTableViewCell *)[self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(cell == nil){
        cell = [[[NSBundle mainBundle] loadNibNamed:@"MenuTableViewCell" owner:self options:nil] objectAtIndex:0];
    }
    
    Menu *menu = [self.dataArray objectAtIndex:indexPath.row];
    
    [cell.cellTitle setText:[menu desc]];
    [cell.cellImage setImage:[menu image]];
    
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self callSegue:[self.dataArray objectAtIndex:indexPath.row]]; 
}


#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return [self.dataArray count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"cvCell";
    
    UICollectionViewCell *cell = [self.collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    
    Menu *menu = [self.dataArray objectAtIndex:indexPath.row];
    UIImageView *imageView = (UIImageView *)[cell viewWithTag:100];
    imageView.image = [menu image];
    
    cell.backgroundColor = [UIColor clearColor];
    
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 72;
}


#pragma mark <UICollectionViewDelegate>

// Uncomment this method to specify if the specified item should be selected
- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self callSegue:[self.dataArray objectAtIndex:indexPath.row]]; 
    
    return YES;
}

#pragma mark Navigation
// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"SecretarySegue"]){
        SecretaryServiceViewController *secService = [segue destinationViewController];
        secService.secretary = sender;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
