#include <stdio.h>
#include "../lib/msg1.h"
#include "../lib/msg2.h"

int main()
{
  printf("%s %s", getMsg1(), getMsg2());
  return 0;
}

