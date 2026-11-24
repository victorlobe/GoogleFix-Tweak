#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "GFRootListController.h"

@implementation GFRootListController

- (NSArray *)specifiers {
	if (!_specifiers) {
		_specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
	}
	return _specifiers;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [super tableView:tableView cellForRowAtIndexPath:indexPath];
	if (indexPath.section != 0 || indexPath.row != 0) return cell;

	cell.textLabel.hidden = YES;
	cell.detailTextLabel.hidden = YES;
	cell.selectionStyle = UITableViewCellSelectionStyleNone;
	cell.backgroundColor = [UIColor clearColor];
	cell.backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
	cell.selectedBackgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
	cell.contentView.backgroundColor = [UIColor clearColor];

	if (![cell.contentView viewWithTag:1984]) {
		NSString *iconPath = [[NSBundle bundleForClass:[self class]] pathForResource:@"headerIcon" ofType:@"png"];
		UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 12.0, 96.0, 96.0)];
		iconView.tag = 1984;
		iconView.image = iconPath ? [UIImage imageWithContentsOfFile:iconPath] : nil;
		iconView.contentMode = UIViewContentModeScaleAspectFit;
		iconView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
		iconView.center = CGPointMake(cell.contentView.bounds.size.width / 2.0, 60.0);
		[cell.contentView addSubview:iconView];

		UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 112.0, cell.contentView.bounds.size.width, 24.0)];
		label.tag = 1985;
		label.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		label.text = @"GoogleFix";
		label.textAlignment = NSTextAlignmentCenter;
		label.font = [UIFont boldSystemFontOfSize:17.0];
		label.textColor = [UIColor darkTextColor];
		label.backgroundColor = [UIColor clearColor];
		[cell.contentView addSubview:label];
	}
	return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
	if (indexPath.section == 0 && indexPath.row == 0) return 148.0;
	return [super tableView:tableView heightForRowAtIndexPath:indexPath];
}

@end
