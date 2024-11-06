#include <pthread.h>
#include <semaphore.h>
#include <stdlib.h>
#include <stdio.h>

sem_t IP_ED, M1_M2, F1_F2, ED_PA, ED_BD, M2_PA, M2_IA, M2_BDD, M2_AA, F2_RC, F2_CG, F2_RO, PA_RC, PA_SO, PA_IS, PA_IA, PA_CG, PA_RO, PA_AA, BD_SI, BD_DW, BD_BDD, RC_SO, RC_SI, RC_DW, RC_SD, SO_SD, SO_CS, SI_CS;

void *IP(void * x) {
	printf("IP\n");
	sem_post(&IP_ED);
}

void *M1(void * x) {
	printf("M1\n");
	sem_post(&M1_M2);
}

void *F1(void * x) {
	printf("F1\n");
	sem_post(&F1_F2);
}

void *ED(void * x) {
	sem_wait(&IP_ED);
	printf("ED\n");
	sem_post(&ED_PA);
	sem_post(&ED_BD);
}

void *M2(void * x) {
	sem_wait(&M1_M2);
	printf("M2\n");
	sem_post(&M2_PA);
	sem_post(&M2_IA);
	sem_post(&M2_BDD);
	sem_post(&M2_AA);
}

void *F2(void * x) {
	sem_wait(&F1_F2);
	printf("F2\n");
	sem_post(&F2_RC);
	sem_post(&F2_CG);
	sem_post(&F2_RO);
}

void *PA(void * x) {
	sem_wait(&ED_PA);
	sem_wait(&M2_PA);
	printf("PA\n");
	sem_post(&PA_RC);
	sem_post(&PA_SO);
	sem_post(&PA_IS);
	sem_post(&PA_IA);
	sem_post(&PA_CG);
	sem_post(&PA_RO);
	sem_post(&PA_AA);
}

void *BD(void * x) {
	sem_wait(&ED_BD);
	printf("BD\n");
	sem_post(&BD_SI);
	sem_post(&BD_DW);
	sem_post(&BD_BDD);
}

void *RC(void * x) {
	sem_wait(&PA_RC);
	sem_wait(&F2_RC);
	printf("RC\n");
	sem_post(&RC_SO);
	sem_post(&RC_SI);
	sem_post(&RC_DW);
	sem_post(&RC_SD);
}

void *SO(void * x) {
	sem_wait(&PA_SO);
	sem_wait(&RC_SO);
	printf("SO\n");
	sem_post(&SO_SD);
	sem_post(&SO_CS);
}

void *IS(void * x) {
	sem_wait(&PA_IS);
	printf("IS\n");
}

void *SI(void * x) {
	sem_wait(&RC_SI);
	sem_wait(&BD_SI);
	printf("SI\n");
	sem_post(&SI_CS);
}

void *IA(void * x) {
	sem_wait(&PA_IA);
	sem_wait(&M2_IA);
	printf("IA\n");
}

void *CG(void * x) {
	sem_wait(&F2_CG);
	sem_wait(&PA_CG);
	printf("CG\n");
}

void *DW(void * x) {
	sem_wait(&BD_DW);
	sem_wait(&RC_DW);
	printf("DW\n");
}

void *SD(void * x) {
	sem_wait(&SO_SD);
	sem_wait(&RC_SD);
	printf("SD\n");
}

void *BDD(void * x) {
	sem_wait(&BD_BDD);
	sem_wait(&M2_BDD);
	printf("BDD\n");
}

void *RO(void * x) {
	sem_wait(&F2_RO);
	sem_wait(&PA_RO);
	printf("RO\n");
}

void *CS(void * x) {
	sem_wait(&SI_CS);
	sem_wait(&SO_CS);
	printf("CS\n");
}

void *AA(void * x) {
	sem_wait(&PA_AA);
	sem_wait(&M2_AA);
	printf("AA\n");
}


int main() {

	pthread_t hilo_1, hilo_2, hilo_3, hilo_4, hilo_5, hilo_6, hilo_7, hilo_8, hilo_9, hilo_10, hilo_11, hilo_12, hilo_13, hilo_14, hilo_15, hilo_16, hilo_17, hilo_18, hilo_19, hilo_20, hilo_21, hilo_22, hilo_23, hilo_24, hilo_25, hilo_26, hilo_27, hilo_28, hilo_29;
	pthread_attr_t attr;
	pthread_attr_init(&attr);;

	sem_init(&IP_ED, 0, 1);
	sem_init(&M1_M2, 0, 1);
	sem_init(&F1_F2, 0, 1);
	sem_init(&ED_PA, 0, 0);
	sem_init(&ED_BD, 0, 0);
	sem_init(&M2_PA, 0, 0);
	sem_init(&M2_IA, 0, 0);
	sem_init(&M2_BDD, 0, 0);
	sem_init(&M2_AA, 0, 0);
	sem_init(&F2_RC, 0, 0);
	sem_init(&F2_CG, 0, 0);
	sem_init(&F2_RO, 0, 0);
	sem_init(&PA_RC, 0, 0);
	sem_init(&PA_SO, 0, 0);
	sem_init(&PA_IS, 0, 0);
	sem_init(&PA_IA, 0, 0);
	sem_init(&PA_CG, 0, 0);
	sem_init(&PA_RO, 0, 0);
	sem_init(&PA_AA, 0, 0);
	sem_init(&BD_SI, 0, 0);
	sem_init(&BD_DW, 0, 0);
	sem_init(&BD_BDD, 0, 0);
	sem_init(&RC_SO, 0, 0);
	sem_init(&RC_SI, 0, 0);
	sem_init(&RC_DW, 0, 0);
	sem_init(&RC_SD, 0, 0);
	sem_init(&SO_SD, 0, 0);
	sem_init(&SO_CS, 0, 0);
	sem_init(&SI_CS, 0, 0);

	pthread_create(&hilo_1, &attr, IP, NULL);
	pthread_create(&hilo_2, &attr, M1, NULL);
	pthread_create(&hilo_3, &attr, F1, NULL);
	pthread_create(&hilo_4, &attr, ED, NULL);
	pthread_create(&hilo_5, &attr, M2, NULL);
	pthread_create(&hilo_6, &attr, F2, NULL);
	pthread_create(&hilo_7, &attr, PA, NULL);
	pthread_create(&hilo_8, &attr, BD, NULL);
	pthread_create(&hilo_9, &attr, RC, NULL);
	pthread_create(&hilo_10, &attr, SO, NULL);
	pthread_create(&hilo_11, &attr, IS, NULL);
	pthread_create(&hilo_12, &attr, SI, NULL);
	pthread_create(&hilo_13, &attr, IA, NULL);
	pthread_create(&hilo_14, &attr, CG, NULL);
	pthread_create(&hilo_15, &attr, DW, NULL);
	pthread_create(&hilo_16, &attr, SD, NULL);
	pthread_create(&hilo_17, &attr, BDD, NULL);
	pthread_create(&hilo_18, &attr, RO, NULL);
	pthread_create(&hilo_19, &attr, CS, NULL);
	pthread_create(&hilo_20, &attr, AA, NULL);

	pthread_join(hilo_1, NULL);
	pthread_join(hilo_2, NULL);
	pthread_join(hilo_3, NULL);
	pthread_join(hilo_4, NULL);
	pthread_join(hilo_5, NULL);
	pthread_join(hilo_6, NULL);
	pthread_join(hilo_7, NULL);
	pthread_join(hilo_8, NULL);
	pthread_join(hilo_9, NULL);
	pthread_join(hilo_10, NULL);
	pthread_join(hilo_11, NULL);
	pthread_join(hilo_12, NULL);
	pthread_join(hilo_13, NULL);
	pthread_join(hilo_14, NULL);
	pthread_join(hilo_15, NULL);
	pthread_join(hilo_16, NULL);
	pthread_join(hilo_17, NULL);
	pthread_join(hilo_18, NULL);
	pthread_join(hilo_19, NULL);
	pthread_join(hilo_20, NULL);

	return 0;
}
