module handlers;

import map;
import hero;
import mobs;
import random;
import color;
import commands;

import std.stdio;
import std.process;


void coordHandler() {

    exploration();

    auto suitable = generateMobs();

    for(int t = 0; t < suitable.length; ++t) {
        if (randomInt(3) == 1){}
        else {
            auto battleResult = battle( get(suitable[t]) );
            if (battleResult == "try to escape") {
                switch (randomInt(100)) {
                    case 1: hero.hero.die();
                }
            }


        }
    }
}

string battle(Mob withMob) {
    printHeroInfo();
    writeln('\n',withMob.name," напал на вас!\n\r\tЧто будем делать?");

    for (;;) {
        string command = "Unique command";
        write("\r >", RED);
        stdin.readln(command);
        write(DEFAULT, "\r");

        if (processBattleCommand(command) == false) return "try to escape";
    }

}











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
