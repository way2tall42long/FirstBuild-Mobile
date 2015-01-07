//
//  MilkGallonClippingView.m
//  MobiUs
//
//  Created by Myles Caley on 1/6/15.
//  Copyright (c) 2015 FirstBuild. All rights reserved.
//

#import "MilkGallonClippingView.h"

@implementation MilkGallonClippingView



// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    [super drawRect:rect];
    UIColor* strokeColor = [UIColor colorWithRed: 0 green: 0 blue: 0 alpha: 1];
    UIBezierPath* path = [UIBezierPath bezierPath];
    [path moveToPoint: CGPointMake(1935,1448)];
    [path addCurveToPoint: CGPointMake(1905,1232) controlPoint1: CGPointMake(1921,1316) controlPoint2: CGPointMake(1928,1266)];
    [path addCurveToPoint: CGPointMake(1778,1151) controlPoint1: CGPointMake(1883,1198) controlPoint2: CGPointMake(1790,1167)];
    [path addCurveToPoint: CGPointMake(1767,1136) controlPoint1: CGPointMake(1771,1141) controlPoint2: CGPointMake(1767,1136)];
    [path addCurveToPoint: CGPointMake(1767,1134) controlPoint1: CGPointMake(1767,1136) controlPoint2: CGPointMake(1767,1135)];
    [path addCurveToPoint: CGPointMake(1769,1129) controlPoint1: CGPointMake(1768,1133) controlPoint2: CGPointMake(1769,1131)];
    [path addCurveToPoint: CGPointMake(1765,1124) controlPoint1: CGPointMake(1769,1127) controlPoint2: CGPointMake(1767,1125)];
    [path addCurveToPoint: CGPointMake(1764,1117) controlPoint1: CGPointMake(1765,1120) controlPoint2: CGPointMake(1764,1117)];
    [path addCurveToPoint: CGPointMake(1764,1083) controlPoint1: CGPointMake(1764,1115) controlPoint2: CGPointMake(1764,1083)];
    [path addCurveToPoint: CGPointMake(1711,1075) controlPoint1: CGPointMake(1764,1083) controlPoint2: CGPointMake(1762,1075)];
    [path addCurveToPoint: CGPointMake(1661,1086) controlPoint1: CGPointMake(1711,1075) controlPoint2: CGPointMake(1661,1075)];
    [path addCurveToPoint: CGPointMake(1661,1118) controlPoint1: CGPointMake(1661,1098) controlPoint2: CGPointMake(1661,1118)];
    [path addLineToPoint: CGPointMake(1659,1123)];
    [path addCurveToPoint: CGPointMake(1654,1129) controlPoint1: CGPointMake(1656,1123) controlPoint2: CGPointMake(1654,1126)];
    [path addCurveToPoint: CGPointMake(1656,1134) controlPoint1: CGPointMake(1654,1131) controlPoint2: CGPointMake(1654,1133)];
    [path addLineToPoint: CGPointMake(1653,1143)];
    [path addLineToPoint: CGPointMake(1579,1189)];
    [path addLineToPoint: CGPointMake(1569,1226)];
    [path addLineToPoint: CGPointMake(1544,1253)];
    [path addCurveToPoint: CGPointMake(1496,1604) controlPoint1: CGPointMake(1544,1253) controlPoint2: CGPointMake(1496,1461)];
    [path addCurveToPoint: CGPointMake(1503,1706) controlPoint1: CGPointMake(1496,1672) controlPoint2: CGPointMake(1503,1706)];
    [path addCurveToPoint: CGPointMake(1527,1745) controlPoint1: CGPointMake(1503,1706) controlPoint2: CGPointMake(1512,1731)];
    [path addCurveToPoint: CGPointMake(1591,1759) controlPoint1: CGPointMake(1541,1759) controlPoint2: CGPointMake(1566,1759)];
    [path addCurveToPoint: CGPointMake(1821,1758) controlPoint1: CGPointMake(1616,1759) controlPoint2: CGPointMake(1821,1758)];
    [path addLineToPoint: CGPointMake(1832,1749)];
    [path addLineToPoint: CGPointMake(1843,1760)];
    [path addLineToPoint: CGPointMake(1891,1760)];
    [path addCurveToPoint: CGPointMake(1926,1725) controlPoint1: CGPointMake(1891,1760) controlPoint2: CGPointMake(1917,1761)];
    [path addCurveToPoint: CGPointMake(1935,1448) controlPoint1: CGPointMake(1935,1690) controlPoint2: CGPointMake(1950,1579)];
    [strokeColor setStroke];
    path.lineWidth = 0.5;
    [path stroke];
    
    self.clippingPath = path;
    
    UIColor* strokeColor1 = [UIColor colorWithRed: 0 green: 0 blue: 0 alpha: 1];
    UIBezierPath* path1 = [UIBezierPath bezierPath];
    [path1 moveToPoint: CGPointMake(1660,1120)];
    [path1 addCurveToPoint: CGPointMake(1713,1114) controlPoint1: CGPointMake(1675,1116) controlPoint2: CGPointMake(1693,1114)];
    [path1 addCurveToPoint: CGPointMake(1765,1120) controlPoint1: CGPointMake(1732,1114) controlPoint2: CGPointMake(1750,1116)];
    [strokeColor1 setStroke];
    path1.lineWidth = 0.5;
    [path1 stroke];
    
    UIColor* strokeColor2 = [UIColor colorWithRed: 0 green: 0 blue: 0 alpha: 1];
    UIBezierPath* path2 = [UIBezierPath bezierPath];
    [path2 moveToPoint: CGPointMake(1642,1408)];
    [path2 addCurveToPoint: CGPointMake(1620,1427) controlPoint1: CGPointMake(1641,1419) controlPoint2: CGPointMake(1631,1427)];
    [path2 addLineToPoint: CGPointMake(1620,1427)];
    [path2 addCurveToPoint: CGPointMake(1601,1405) controlPoint1: CGPointMake(1609,1426) controlPoint2: CGPointMake(1601,1416)];
    [path2 addLineToPoint: CGPointMake(1613,1233)];
    [path2 addCurveToPoint: CGPointMake(1634,1214) controlPoint1: CGPointMake(1613,1222) controlPoint2: CGPointMake(1623,1213)];
    [path2 addLineToPoint: CGPointMake(1634,1214)];
    [path2 addCurveToPoint: CGPointMake(1653,1236) controlPoint1: CGPointMake(1645,1215) controlPoint2: CGPointMake(1654,1225)];
    [path2 addLineToPoint: CGPointMake(1642,1408)];
    [strokeColor2 setStroke];
    path2.lineWidth = 0.5;
    [path2 stroke];
    
    UIColor* strokeColor3 = [UIColor colorWithRed: 0 green: 0 blue: 0 alpha: 1];
    UIBezierPath* path3 = [UIBezierPath bezierPath];
    [path3 moveToPoint: CGPointMake(1570,1222)];
    [path3 addCurveToPoint: CGPointMake(1542,1425) controlPoint1: CGPointMake(1570,1222) controlPoint2: CGPointMake(1552,1411)];
    [path3 addCurveToPoint: CGPointMake(1520,1450) controlPoint1: CGPointMake(1533,1439) controlPoint2: CGPointMake(1520,1450)];
    [strokeColor3 setStroke];
    path3.lineWidth = 0.5;
    [path3 stroke];
    
    

    
    
}


@end
