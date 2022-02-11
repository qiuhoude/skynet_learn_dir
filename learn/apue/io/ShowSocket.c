#include <stdio.h>
#include <dirent.h>
#include <string.h>
#include <unistd.h>


static void show(void)
{
	const char *root = getenv("PROC_ROOT") ? NULL : "/proc/";
	struct dirent *d;
	char name[1024];
	int nameoff;
	DIR *dir;

	strcpy(name, root);
	if (strlen(name) == 0 || name[strlen(name)-1] != '/')
		strcat(name, "/");

	nameoff = strlen(name);

	dir = opendir(name);
	if (!dir)
		return;
    printf("ino process pid fd task\n");
	while ((d = readdir(dir)) != NULL) {
		struct dirent *d1;
		char process[16];
		int pid, pos;
		DIR *dir1;
		char crap;

		if (sscanf(d->d_name, "%d%c", &pid, &crap) != 1)
			continue;

		sprintf(name + nameoff, "%d/fd/", pid);
		pos = strlen(name);
		if ((dir1 = opendir(name)) == NULL)
			continue;

		process[0] = '\0';

		while ((d1 = readdir(dir1)) != NULL) {
			const char *pattern = "socket:[";
			unsigned int ino;
			char lnk[64];
			int fd;
			ssize_t link_len;

			if (sscanf(d1->d_name, "%d%c", &fd, &crap) != 1)
				continue;

			sprintf(name+pos, "%d", fd);

			link_len = readlink(name, lnk, sizeof(lnk)-1);
			if (link_len == -1)
				continue;
			lnk[link_len] = '\0';

			if (strncmp(lnk, pattern, strlen(pattern)))
				continue;

			sscanf(lnk, "socket:[%u]", &ino);

			if (process[0] == '\0') {
				char tmp[1024];
				FILE *fp;

				snprintf(tmp, sizeof(tmp), "%s/%d/stat", root, pid);
				if ((fp = fopen(tmp, "r")) != NULL) {
					fscanf(fp, "%*d (%[^)])", process);
					fclose(fp);
				}
			}
            printf("%u %s %d %d \n",ino, process, pid, fd);
		}
    
		closedir(dir1);
	}
	closedir(dir);
}

int main(){
    show();
}