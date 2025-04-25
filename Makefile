
cc := gcc
cflags := -std=c99 -Wall -Wextra -Werror

src := src/*.c
libs := -lreadline

mal: src
	$(cc) $(cflags) $(src) $(libs) -o bin/mal

clean:
	rm -f bin/*
