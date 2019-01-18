#include <stdio.h>
#include "lib/msg1.h"
#include "lib/msg3.h"

int main()
{
  printf("%s %s", getMsg1(), getMsg3());
  return 0;
}

