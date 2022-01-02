convention: string args are labelled $1, $2, ...
file args are /dev/fd/3/, /dev/fd/4 ...

each arg takes up one arg slot 
hence, if there are 3 args they are:

command $1 $2 $3
or
command $1 /dev/fd/4 $3
or ...

i.e. if 1st arg is a string, it is $1, else it is /dev/fd/3
i.e. if 2nd arg is a string, it is $2, else it is /dev/fd/4
i.e. if 3rd arg is a string, it is $3, else it is /dev/fd/5
...
