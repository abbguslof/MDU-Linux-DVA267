## Fråga 1 | Kan *Bob* ändra innehållet i filen ***schedule.txt***? Varför/varför inte?

Nej, gruppen *solarproj* har inga skrivrättigheter.

## Fråga 2 | Kan *Alice* ta bort filen ***controller.c***? Varför/varför inte?

Nej, Sticky bit är satt på katalogen *solarproj*.

## Fråga 3 | Vem kan läsa filen ***power***? Varför?

Alla andra förutom ägare och medlemmar i gruppen *solarproj*.

## Fråga 4 | Varför kan *Alice* men inte *Bob* byta arbetskatalog till ***old***?

*Alice* har exekveringsrättigheter på katalogen **old** men gruppen *solarproj* har inte exekveringsrättigheter.

## Fråga 5 | Kan *Alice* läsa filen  ***temp.sym***? Varför/varför inte?

Nej, *Alice* kan läsa länken men har inte läsrättigheter på filen **temp.**

## Fråga 6 | *Alice* har installerat **openssh-server** på en dator för att låta *Bob* fjärransluta till datorn (Xubuntu/Ubuntu).

Vilket kommando ska hon använda för att se status på tjänsten(‘service’) **ssh**?
`systemctl status ssh`

Hur kan tjänsten(‘service’) **ssh** stoppas?
`sudo systemctl stop ssh`

Hur kan tjänsten(‘service’) **ssh** startas?
`sudo systemctl start ssh`
