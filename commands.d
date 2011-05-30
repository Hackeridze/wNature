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
