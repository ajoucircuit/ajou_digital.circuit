#include<stdio.h>
#include<stdlib.h>
#include<string.h>

#define CRC32_poly 0x1814141AB  // ����� polynomial
#define BUFSIZE 600 //�����Ӱ� ũ�� ����

int main()
{
	char data[BUFSIZE];
	unsigned int size;

	printf("�����͸� �Է��ϼ��� : ");
	gets(data);

	size = strlen(data);

	printf("CRC is 0x%X\n", crc_gen(data, size));
	printf("Remainder : 0x%X\n", Err_check(data, size));

	data[0] = data[0] + 2; //���� ����

	data[1] = data[1] + 9;

	printf("������ �߻����� ����� Remainder : 0x%X\n", Err_check(data, size));

	return 0;
}

unsigned int crc_gen(char* data, int size)
{
	unsigned long int crc;
	unsigned long int datalen;
	int i;
	unsigned long int msb = 0;

	datalen = size * 8; // size�� byte �����̹Ƿ� 8�� ���Ѵ�.

	data[size] = 0;
	data[size + 1] = 0;
	data[size + 2] = 0;
	data[size + 3] = 0;
	// data�ڿ� 32bit�� 0�� �ٿ���

	crc = data[0] << 24;
	crc += data[1] << 16;
	crc += data[2] << 8;
	crc += data[3];
	// �Է��� data �� 32bit�� crc�� ����

	for (i = 0; i < datalen; i++)
	{
		msb = crc & 0x80000000;
		crc = crc << 1;

		crc += (data[i / 8 + 4] >> (7 - (i % 8))) & 1;

		if (msb)
			crc = crc ^ CRC32_poly;
	}
	// msb�� 1�̸� divisior�� XOR����, msb�� 0�̸� �������� 1bit shift, ���� �ٽ� data �����.

	// ���� ������ packet ���� : data + crc-code
	data[size] = (crc >> 24) & 0xff;
	data[size + 1] = (crc >> 16) & 0xff;
	data[size + 2] = (crc >> 8) & 0xff;
	data[size + 3] = crc & 0xff;
	// 8bit�� ����

	return crc;
}
unsigned int Err_check(const char* data, int size) // ������ üũ�ϴ� �Լ� ����
{
	unsigned long int crc;
	unsigned long int datalen;
	int i;
	unsigned long int msb = 0;

	datalen = size * 8;

	crc = data[0] << 24;
	crc += data[1] << 16;
	crc += data[2] << 8;
	crc += data[3];
	//������ data �� 32bit�� crc�� ����x

	for (i = 0; i < datalen; i++)
	{
		msb = crc & 0x80000000;
		crc = crc << 1;

		crc += (data[i / 8 + 4] >> (7 - (i % 8))) & 1;

		if (msb)
			crc = crc ^ CRC32_poly;
	}
	//crc generator�� ���� ������� modulo 2 ������ ���� ����

	return crc;
}