#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAXLINE 4096

char* READ(char* token);
char* EVAL(char* expre);
char* PRINT(char* result);

int main() {

  char* line = NULL;
  size_t line_size = 0;
  ssize_t line_len = 0;
  do {
    fprintf(stdout, "user> ");
    line_len = getline(&line, &line_size, stdin);
    PRINT(EVAL(READ(line)));
  } while (line_len != EOF);

  if (line) { free(line); }
  return EXIT_SUCCESS;
}

char* READ(char* token) {
  return token;
}

char* EVAL(char* expre) {
  return expre;
}

char* PRINT(char* result) {
  return result;
}
