#include<stdio.h>
#include<stdlib.h>
#include<string.h>

#define CRC32_poly 0x1814141AB  // 사용할 polynomial
#define BUFSIZE 600 //여유롭게 크게 설정

int main()
{
	char data[BUFSIZE];
	unsigned int size;

	printf("데이터를 입력하세요 : ");
	gets(data);

	size = strlen(data);

	printf("CRC is 0x%X\n", crc_gen(data, size));
	printf("Remainder : 0x%X\n", Err_check(data, size));

	data[0] = data[0] + 2; //에러 생성

	data[1] = data[1] + 9;

	printf("에러가 발생했을 경우의 Remainder : 0x%X\n", Err_check(data, size));

	return 0;
}

unsigned int crc_gen(char* data, int size)
{
	unsigned long int crc;
	unsigned long int datalen;
	int i;
	unsigned long int msb = 0;

	datalen = size * 8; // size는 byte 단위이므로 8을 곱한다.

	data[size] = 0;
	data[size + 1] = 0;
	data[size + 2] = 0;
	data[size + 3] = 0;
	// data뒤에 32bit의 0을 붙여줌

	crc = data[0] << 24;
	crc += data[1] << 16;
	crc += data[2] << 8;
	crc += data[3];
	// 입력할 data 앞 32bit를 crc에 저장

	for (i = 0; i < datalen; i++)
	{
		msb = crc & 0x80000000;
		crc = crc << 1;

		crc += (data[i / 8 + 4] >> (7 - (i % 8))) & 1;

		if (msb)
			crc = crc ^ CRC32_poly;
	}
	// msb가 1이면 divisior와 XOR연산, msb가 0이면 왼쪽으로 1bit shift, 이후 다시 data 끌어옴.

	// 최종 전송할 packet 생성 : data + crc-code
	data[size] = (crc >> 24) & 0xff;
	data[size + 1] = (crc >> 16) & 0xff;
	data[size + 2] = (crc >> 8) & 0xff;
	data[size + 3] = crc & 0xff;
	// 8bit씩 저장

	return crc;
}
unsigned int Err_check(const char* data, int size) // 에러를 체크하는 함수 선언
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
	//생성된 data 앞 32bit를 crc에 저장x

	for (i = 0; i < datalen; i++)
	{
		msb = crc & 0x80000000;
		crc = crc << 1;

		crc += (data[i / 8 + 4] >> (7 - (i % 8))) & 1;

		if (msb)
			crc = crc ^ CRC32_poly;
	}
	//crc generator와 같은 방식으로 modulo 2 나눗셈 연산 진행

	return crc;
}