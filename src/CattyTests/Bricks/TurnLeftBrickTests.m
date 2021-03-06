/**
 *  Copyright (C) 2010-2019 The Catrobat Team
 *  (http://developer.catrobat.org/credits)
 *
 *  This program is free software: you can redistribute it and/or modify
 *  it under the terms of the GNU Affero General Public License as
 *  published by the Free Software Foundation, either version 3 of the
 *  License, or (at your option) any later version.
 *
 *  An additional term exception under section 7 of the GNU Affero
 *  General Public License, version 3, is available at
 *  (http://developer.catrobat.org/license_additional_term)
 *
 *  This program is distributed in the hope that it will be useful,
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of
 *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 *  GNU Affero General Public License for more details.
 *
 *  You should have received a copy of the GNU Affero General Public License
 *  along with this program.  If not, see http://www.gnu.org/licenses/.
 */

#import <XCTest/XCTest.h>
#import "AbstractBrickTests.h"
#import "WhenScript.h"
#import "SpriteObject.h"
#import "Pocket_Code-Swift.h"

@interface TurnLeftBrickTests : AbstractBrickTests
@end

@implementation TurnLeftBrickTests

- (void)setUp
{
    [super setUp];
}

- (void)tearDown
{
    // Put teardown code here; it will be run once, after the last test case.
    [super tearDown];
}

- (void)testTurnLeftBrick
{
    [self turnLeftWithInitialRotation:90 andRotation:60];
    [self turnLeftWithInitialRotation:0 andRotation:60];
    [self turnLeftWithInitialRotation:90 andRotation:400];
}

- (void)testTurnLeftBrickNegative
{
    [self turnLeftWithInitialRotation:90 andRotation:-60];
}

- (void)testTurnLeftBrickNegativeOver360
{
    [self turnLeftWithInitialRotation:90 andRotation:-400];
}

- (void)turnLeftWithInitialRotation:(CGFloat)initialRotation andRotation:(CGFloat)rotation
{
    SpriteObject *object = [[SpriteObject alloc] init];
    CBSpriteNode *spriteNode = [[CBSpriteNode alloc] initWithSpriteObject:object];
    object.spriteNode = spriteNode;
    
    spriteNode.catrobatRotation = initialRotation;
    
    Script *script = [[WhenScript alloc] init];
    script.object = object;
    
    TurnLeftBrick* brick = [[TurnLeftBrick alloc] init];
    brick.script = script;
    
    brick.degrees = [[Formula alloc] initWithFloat:rotation];
    
    dispatch_block_t action = [brick actionBlock:self.formulaInterpreter];
    action();
    
    CGFloat expectedRawRotation = [[RotationSensor class] convertToRawWithUserInput:(initialRotation - rotation) for: object];
    XCTAssertEqualWithAccuracy(expectedRawRotation, spriteNode.zRotation, 0.0001, @"TurnLeftBrick not correct");
}

@end
