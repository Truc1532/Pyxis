void itoa(int value, char *buffer) {
	char temp[10];
	int i = 0;
	if (value == 0) {
		buffer[0] = '0';
		buffer[1] = '\0';
		return;
	}

	while (value > 0) {
		temp[i++] = '0' + (value % 10);
		value /= 10;
	}

	for (int j = 0; j < i; j++) {
		buffer[j] = temp[i - j - 1];
	}
	buffer[i] = '\0';
}


		
