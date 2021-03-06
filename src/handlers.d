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
module handlers;

import map;
import hero;
import mobs;
import random;
import color;
import commands;

import std.stdio;
import std.process;

/**
* Hero's coords handler, makes battles, opening territories etc.
*/
void coordHandler(Hero player) {

    exploration();

    auto suitable = generateMobs(); /// Mobs here, suitable for this locality and hero's rating

    for(int t = 0; t < suitable.length; ++t) {

        auto attacker = get(suitable[t]);

        if ((randomInt(3) == 1) || (attacker.bellicosity == false)) continue;
        else {
            player.printInfo();

            auto battleResult = battle(attacker, player);

            if      (battleResult == "try to escape") {
                switch (randomInt(15)) {
                    case 1: player.dieNow();
                    break;
                    case 2:
                    case 3:
                    case 4:
                    case 5:
                    case 6:
                    case 7:
                    case 8:
                    case 9:
                    case 10:
                    case 11:
                    case 12: player.takingDamage( attacker );
                             writeln(" You managed to escape from the ",attacker.name,'!');
                    break;
                    case 13:
                    case 14:
                    case 15: write("And you're lucky!");
                             writeln( " You managed to escape from the ",attacker.name,'!');
                    break;
                }
            }
            else if(battleResult == "herowin")
                    writeln("\n You win ",attacker.name,"!");
            //else if(battleResult == "mobwin")
               //     writeln("\n You win ",atacker.name,"!");
        }
    }
}

/**
* Battle-func
*/
string battle(Mob withMob, Hero player) {
    writeln('\n',withMob.name," attack you!\n\r\tWhat shall we do?");


    string command = "Unique command";
    for (;;) {
        write("\r >", RED);
        stdin.readln(command);
        write(DEFAULT, "\r");

        auto processingAnswer = processBattleCommand(command);

        if (processingAnswer == "false") return "try to escape";
        else if (processingAnswer
                        == "let the battle begin")
            while (withMob.death() == false && player.death() == false) {
                player.takingDamage( withMob );
                withMob.takingDamage(player.useSkills());
                writeln(withMob.healthNow);
            }
    }
    if (withMob.death() == true) return "herowin";
    else return "mobwin";
}


/**
* Func, for opening territories
*/
void exploration() {
    int x = hero.hero.coord.x; /// column
    int y = hero.hero.coord.y; /// row

    worldMap[x][y].open = true;
    worldMap[x+1][y].open = true;
    worldMap[x][y+1].open = true;
    worldMap[x-1][y].open = true;
    worldMap[x][y-1].open = true;

    worldMap[x+2][y].open = true;
    worldMap[x][y+2].open = true;
    worldMap[x-2][y].open = true;
    worldMap[x][y-2].open = true;

    worldMap[x+1][y+1].open = true;
    worldMap[x-1][y+1].open = true;
    worldMap[x-1][y-1].open = true;
    worldMap[x+1][y-1].open = true;

    worldMap[x+3][y].open = true;
    worldMap[x][y+3].open = true;
    worldMap[x-3][y].open = true;
    worldMap[x][y-3].open = true;

    worldMap[x+2][y+1].open = true;
    worldMap[x+1][y+2].open = true;
    worldMap[x-2][y+1].open = true;
    worldMap[x+1][y-2].open = true;

    worldMap[x+2][y-1].open = true;
    worldMap[x-1][y+2].open = true;
    worldMap[x-2][y-1].open = true;
    worldMap[x-1][y-2].open = true;
}
