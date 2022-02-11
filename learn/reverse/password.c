#include <stdio.h>
#include <string.h>

char myPassword[2048];
int passLen, checksum = 0;

void getPassword()
{
    while (1)
    {
        printf("Password: ");
        scanf("%s", myPassword);
        passLen = strlen(myPassword);

        if (passLen == 10)
        {
            for (int i = 0; i < passLen; i++)
                checksum += myPassword[i];
            if (checksum == 1085)
            {
                printf("Ok\n");
                break;
            }
            else
            {

                printf("Try again\n");
            }
        }
    }
}

int main(int argc, char *argv[])
{
    getPassword();
    return 0;
}
