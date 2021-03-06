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

module color; /// Module for the color writing, I see no need to comment all

immutable BLACK="\033[30m";
immutable BLUE="\033[34m";
immutable GREEN="\033[32m";
immutable CYAN="\033[36m";
immutable RED="\033[31m";
immutable PURPLE="\033[35m";
immutable BROWN="\033[33m";
immutable GRAY="\033[38m";


immutable VONBLACK="\033[40m";
immutable VONBLUE="\033[44m";
immutable VONGREEN="\033[42m";
immutable VONLIGHTGREEN="\033[42m";
immutable VONCYAN="\033[46m";
immutable VONRED="\033[41m";
immutable VONPURPLE="\033[45m";
immutable VONBROWN="\033[43m";
immutable VONYELLOW="\033[1;42m";
immutable VONLIGHTGRAY="\033[1;47m";

immutable COLORHERO="\033[1;31;40m";

immutable COLORPLAIN="\033[1;33;42m";
immutable COLORFOREST="\033[30;42m";
immutable COLORDESERT="\033[1;33;43m";
immutable COLORMOUNTAINS="\033[30;47m";
immutable COLORWATER="\033[36;44m";
immutable COLORSHOAL="\033[34;46m";
immutable COLORBANK="\033[1;7;33;46m";
immutable COLORJUNGLE="\033[7;1;32;43m";

immutable COLORNOTOPENED="\033[7;1;30;41m";

immutable LIGHTGRAY="\033[37m";
immutable DARKGRAY="\033[1;30m";
immutable LIGHTBLUE="\033[1;34m";
immutable LIGHTGREEN="\033[1;32m";
immutable LIGHTCYAN="\033[1;36m";
immutable LIGHTRED="\033[1;31m";
immutable LIGHTPURPLE="\033[1;35m";
immutable YELLOW="\033[1;33m";
immutable WHITE="\033[1;37m";

immutable DEFAULT="\033[0m"; /// makes all by default
immutable BOLD="\033[1m"; /// bold (intensive)
immutable UNDERLINE="\033[4m"; /// make underlines
immutable FLASH="\033[5m"; /// flash! not works in "terminator"
immutable REVERSE="\033[7m"; /// revers colors von->font, font->von
immutable NOBOLD="\033[22m"; /// set normal intensity
immutable NOUNDERLINE="\033[24m"; /// no underlines)
immutable NOFLASH="\033[25m"; /// no flash
immutable NOREVERSE="\033[27m";  /// no reverse


/** RUSSIAN
Управление цветом
  \033[0m все атрибуты по умолчанию
  \033[1m жирный шрифт (интенсивный цвет)
  \033[2m полу яркий цвет (тёмно-серый, независимо от цвета)
  \033[4m выделение (ярко-белый, независимо от цвета)
  \033[5m мигающий
  \033[7m реверсия (знаки приобретают цвет фона, а фон -- цвет знаков)
  \033[22m установить нормальную интенсивность
  \033[24m отменить подчеркивание
  \033[25m отменить мигание
  \033[27m отменить реверсию
  \033[30 чёрный цвет знаков
  \033[31 красный цвет знаков
  \033[32 зелёный цвет знаков
  \033[33 коричневый цвет знаков
  \033[34 синий цвет знаков
  \033[35 фиолетовый цвет знаков
  \033[36 цвет морской волны знаков
  \033[37 серый цвет знаков
  \033[40 чёрный цвет фона
  \033[41 красный цвет фона
  \033[42 зелёный цвет фона
  \033[43 коричневый цвет фона
  \033[44 синий цвет фона
  \033[45 фиолетовый цвет фона
  \033[46 цвет морской волны фона
  \033[47 серый цвет фона

Управление положением курсора
  \033[#A передвинуть курсор вверх на # строк
  \033[#B передвинуть курсор вниз на # строк
  \033[#С передвинуть курсор вправо на # столбцов
  \033[#D передвинуть курсор влево на # столбцов
  \033[#E передвинуть курсор вниз на # строк и поставить в начало строки
  \033[#F передвинуть курсор вверх на # строк и поставить в начало строки
  \033[#G переместить курсор в указанный столбец текущей строки
  \033[#;#H задает абсолютные координаты курсора (строка, столбец)
*/


