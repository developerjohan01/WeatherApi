//
//  JailBreak.c
//  WeatherApi
//
//  Created by Johan Nilsson on 2020/04/29.
//  Copyright © 2020 Johan Nilsson. All rights reserved.
//

#include "JailBreak.h"

int isJailbroken()
{
    char* str = "isJailbroken function is called in C\n";
    printf("%s", str);
    // Check 1 : existence of files that are common for jailbroken devices
    // TODO
    // Check 2 : Reading and writing in system directories (sandbox violation)
    // TODO
    return 0; // 0 is false, anything else is true
}

