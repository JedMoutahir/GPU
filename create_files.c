#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main(int argc, char** argv)
{
    const char* folder_path = "data/";
    int num_files = 0;

    if (argc < 2) {
        printf("Usage: create_files N\n");
        return 1;
    }

    num_files = atoi(argv[1]);

    for (int i = 0; i < num_files; i++) {
        char filename[256];
        sprintf(filename, "%sfile%d.txt", folder_path, i);

        FILE* file = fopen(filename, "w");
        fprintf(file, "0");
        fclose(file);
    }

    return 0;
}
