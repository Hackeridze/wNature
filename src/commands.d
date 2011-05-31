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
module commands;

import std.stdio;

import map;
import hero;
import color;

bool processCommand(string command) {

    if (command == "выход\n") return false;

    else if (command == "карта\n") printMapPart(70);

    else if (command == "с\n") hero.hero.goUp();
    else if (command == "ю\n") hero.hero.goDown();
    else if (command == "в\n") hero.hero.goRight();
    else if (command == "з\n") hero.hero.goLeft();

    else if (command == "го с\n") heroGoTo("up");
    else if (command == "го ю\n") heroGoTo("down");
    else if (command == "го в\n") heroGoTo("right");
    else if (command == "го з\n") heroGoTo("left");

    else if (command == "инфо\n") printHeroInfo();

    else if (command == "помощь\n") printCommands();

    return true;
}

void printCommands() {
    write(RED);
    writeln("\n Доступные команды:");
    write(LIGHTRED);
    writeln("\tвыход -- выход, что логично, более чем");

    writeln("\tкарта - карта, вся карта");

    writeln("\tс -- идти на север");
    writeln("\tю -- идти на юг");
    writeln("\tв -- идти на восток");
    writeln("\tз -- идти на запад");

    writeln("\tго с -- идти на север, можно долго");
    writeln("\tго ю -- идти на юг, можно долго");
    writeln("\tго в -- идти на восток, можно долго");
    writeln("\tго з -- идти на запад, можно долго");

    writeln("\tинфо -- инфо о герое, на данный момент");

    write(DEFAULT);
}


bool processBattleCommand(string command) {

    if (command == "бежать\n") return false;

    else if (command == "карта\n") printMapPart(70);

    else if (command == "инфо\n") printHeroInfo();

    else if (command == "помощь\n") printBattleCommands();

    return true;
}
void printBattleCommands() {
    write(RED);
    writeln("\n Доступные команды:");
    write(LIGHTRED);
    writeln("\tбежать -- попытаться стоит...");


    writeln("\tинфо -- инфо о герое, на данный момент");

    write(DEFAULT);
}
