#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <readline/readline.h>
#include <readline/history.h>

char* READ(char* token);
char* EVAL(char* expre);
char* PRINT(char* result);

int main(void) {

  rl_bind_key('\t', rl_complete);
  using_history();

  while (true) {

    char* input = readline("user> ");
    if (!input)
      break;
    add_history(input);

    PRINT(EVAL(READ(input)));

    free(input);
  }

  return EXIT_SUCCESS;
}

char* READ(char* token) {
  return token;
}

char* EVAL(char* expre) {
  return expre;
}

char* PRINT(char* result) {
  printf("=> %s\n", result);
  return result;
}
