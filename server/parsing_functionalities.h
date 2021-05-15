#ifndef PARSING_FUNCTIONALITIES_H
#define PARSING_FUNCTIONALITIES_H

#include <cstdint>

// Sets program parameters, if some parameter is incorrect returns -1, otherwise returns 0.
int setProgramParameters(int argc, char *const argv[], uint32_t *, int64_t *,
                         int64_t *, uint32_t *, uint32_t *, uint32_t *);

#endif /* PARSING_FUNCTIONALITIES_H */