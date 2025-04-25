#include <string.h>
#include <regex.h>

typedef struct Reader {
  char** tokens;
  int position;
} Reader;

/* add safety checks to make sure I am not accessing bad memory here */

char* Reader_next(Reader reader) {
  ++reader.position;
  return reader.tokens[reader.position - 1];
}

char* Reader_peek(Reader reader) {
  return reader.tokens[reader.position];
}

char** tokenize(char* line);

Reader read_str(char* line);
  /* call tokenize and return reader object with tokens and position */
