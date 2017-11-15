#include <stdio.h>
#include <string.h>

int main(int argc, char** argv) {
  char* filename = "test.txt";
  FILE* fp;
  char* data = "Gruffalo crumble";
  char buf[strlen(data)+1];

  printf("Opening %s\n", filename);
  fp = fopen(filename, "w");
  if (fp == NULL) {
    printf("File open failed\n");
    return 1;
  }
  printf("Writing to %s\n", filename);
  if (fwrite(data, sizeof(data[0]), strlen(data), fp) <= 0) {
    printf("Write failed\n");
    return 1;
  }
  printf("Wrote '%s'\n", data);
  printf("Closing %s\n", filename);
  if (fclose(fp) != 0) {
    printf("File close failed\n");
    return 1;
  }
  printf("Opening %s\n", filename);
  fp = fopen(filename, "r");
  if (fp == NULL) {
    printf("File open failed\n");
    return 1;
  }
  printf("Reading from %s\n", filename);
  if (fread(buf, sizeof(data[0]), strlen(data), fp) <= 0) {
    printf("Read failed\n");
    return 1;
  }
  buf[strlen(data)] = '\0';
  printf("Read '%s'\n", buf);
  printf("Closing %s\n", filename);
  if (fclose(fp) != 0) {
    printf("File close failed\n");
    return 1;
  }
}
