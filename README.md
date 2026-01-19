Deux alias de compilation identiques, pour Bash et ZSH

Ils rajoutent trois commandes :

cmp : Permet de compiler avec les flags exigés à 42 (-Wall -Wextra -Werror) en prenant en compte tous les fichiers .c du dossier où la commande est appelée et ses sous-dossiers. Le programme est automatiquement lancé, puis le ./a.out est supprimé.

vmp : Idem mais lance en plus Valgrind. Par défaut, les flags --leak-check=full et --track-origins=yes sont activés.

gmp : Idem mais lance en plus GDB

Pour ces trois commandes, on peut rajouter des flags supplémentaires en les écrivant juste après l'alias. Si l'on veut envoyer des arguments à notre programme, on peut le faire après deux tirets et un espace.

Exemple :
vmp --error-limit=no -- "Civil" "Normaal"

Remerciements à Chatgpt pour les flags
