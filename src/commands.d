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


/**
* Command processor
*/
bool processCommand(string command) {

    if (command == "exit\n") return false;

    else if (command == "map\n") printMapPart();

    else if (command == "n\n") hero.hero.goUp();
    else if (command == "s\n") hero.hero.goDown();
    else if (command == "e\n") hero.hero.goRight();
    else if (command == "w\n") hero.hero.goLeft();

    else if (command == "go n\n") heroGoTo("up");
    else if (command == "go s\n") heroGoTo("down");
    else if (command == "go e\n") heroGoTo("right");
    else if (command == "go w\n") heroGoTo("left");

    else if (command == "info\n") printHeroInfo();

    else if (command == "help\n") printCommands();

    return true;
}

/**
* Print all commands
*/
void printCommands() {
    write(RED);
    writeln("\n Commands:");
    write(LIGHTRED);
    writeln("\texit -- RIGHT exit, do not use Ctrl+C");

    writeln("\tmap -- map, a part of");

    writeln("\tn -- go to the north");
    writeln("\ts -- go to the south");
    writeln("\te -- go to the east");
    writeln("\tw -- go to the west");

    writeln("\tgo n -- go to the north, some times, stops by death");
    writeln("\tgo s -- go to the south, some times, stops by death");
    writeln("\tgo e -- go to the east, some times, stops by death");
    writeln("\tgo w -- go to the west, some times, stops by death");

    writeln("\tinfo -- current info about your hero");

    write(DEFAULT);
}

/**
* Battle commands processor
*/
string processBattleCommand(string command) {

    if (command == "run\n") return "false";

    //else if (command == "map\n") printMapPart();

    else if (command == "info\n") printHeroInfo();

    else if (command == "help\n") printBattleCommands();

    else if (command == "battle\n") return "let the battle begin";
    return "all okay";
}
/**
* Print all battle commands
*/
void printBattleCommands() {
    write(RED);

    writeln("\n Battle commands:");

    write(LIGHTRED);

    writeln("\trun -- you can try to run away from the mob");
    writeln("\tbattle -- you can try to kick mob's ass ;)");
    writeln("\tinfo -- current info about your hero");

    write(DEFAULT);
}
