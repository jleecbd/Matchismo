//
//  SetCard.m
//  Matchismo
//
//  Created by Jeffrey Lee on 2/9/13.
//  Copyright (c) 2013 InfoSynergetics. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

@synthesize symbol = _symbol;

+(NSArray *)validSymbols {
    
    return @[@"▲",@"●", @"■"];
}

+(NSArray *)validColors {
    
    return @[@"Red", @"Purple", @"Green"];
}
+(NSArray *)validShadings {
    
    return @[@"None", @"Partial", @"Full"];
}

@synthesize contents = _contents;

-(NSString *)contents
{
    if (!_contents) _contents = [[NSString alloc] init];
    
    int numSymbols = self.rank;
    _contents = @"";
    
    for(int x=1; x <= numSymbols; x++){
        
        _contents = [_contents stringByAppendingString:self.symbol];
    }

    
    return _contents;
}    

- (int)match:(NSArray *)otherCards
{
    int score = 0;
    
    bool rankMatch = false;
    bool symbolMatch = false;
    bool colorMatch = false;
    bool shadingMatch = false;
    
    SetCard *card1 = [otherCards objectAtIndex:0];
    SetCard *card2 = [otherCards objectAtIndex:1];
    
    if ((self.rank == card1.rank && card1.rank == card2.rank) || (self.rank != card1.rank && card1.rank != card2.rank)) {
        
        rankMatch = true;
        
    } 
    
    if ((self.symbol == card1.symbol && card1.symbol == card2.symbol) || (self.symbol!= card1.symbol && card1.symbol != card2.symbol)) {
        
        symbolMatch = true;
        
    }
    
    if ((self.symbolColor == card1.symbolColor && card1.symbolColor == card2.symbolColor) || (self.symbolColor != card1.symbolColor && card1.symbolColor != card2.symbolColor)) {
        
        colorMatch = true;
        
    }
    
    if ((self.shading == card1.shading && card1.shading == card2.shading) || (self.shading != card1.shading && card1.shading != card2.shading)) {
        
        shadingMatch = true;
        
    }
    
    if (rankMatch && symbolMatch && colorMatch && shadingMatch){
        
        score = 10;
    }
    return score;
}



@end
