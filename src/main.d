/*
* Copyright (c) 2011, Victor Hackeridze All rights reserved.
*
* Redistribution and use in source and binary forms, with or without modification,
* are permitted provided that the following conditions are met:
*
*     Redistributions of source code must retain the above copyright notice, this
* list of conditions and the following disclaimer.
*     Redistributions in binary form must reproduce the above copyright notice, this
* list of conditions and the following disclaimer in the documentation and/or other
* materials provided with the distribution.
*     Neither the name of the HACKERIDZE's BRAIN nor the names of its
* contributors may be used to endorse or promote products derived from this
* software without specific prior written permission.
*
* THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY
* EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
* WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
* IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT,
* INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
* NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR
* PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
* WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
* ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
* POSSIBILITY OF SUCH DAMAGE.
*/
import std.stdio;
import C = std.c.stdio;


import color;
import map;
import random;
import commands;
import hero;
static import skills;
/// ● ● ы, СИМВОЛ)

int main(char[][] args)
{
    writeln(YELLOW, "\t\t\t\twNature", DEFAULT);
    mapInitializator();
    write("Generating hero...");
    heroGenerator(hero.hero);
    skills.simpleAttackInitializator();
    writeln(LIGHTGREEN, " OK", DEFAULT);


    write("Type your name here(15 chars max) >", RED);
    C.scanf("%15s", &hero.hero.name);
    write(DEFAULT);


    writeln();

    hero.hero.printInfo();

    for (;;) {
        string command = "Unique command";
        write("\r >", RED);
        stdin.readln(command);
        write(DEFAULT, "\r");

        if (processCommand(command) == false) break;
    }

    write(DEFAULT, "\r");
    return 0;
}
