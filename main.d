

import std.stdio;
import C = std.c.stdio;


import color;
import map;
import random;
import commands;
import hero;
/// ● ● ы, СИМВОЛ)

int main(char[][] args)
{
    writeln(YELLOW, "RPG, IM DYNAMITE!", DEFAULT);
    mapInitializator();
    write("Генерация героя...");
    heroGenerator(hero.hero);
    writeln(LIGHTGREEN, " OK", DEFAULT);


    write("Введите свой ник >", RED);
    C.scanf("%10s", &hero.hero.name);
    write(DEFAULT);


    writeln();

    printHeroInfo();

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
