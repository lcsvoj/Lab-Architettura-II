# [Sessione 6] Procedure ricorsive

## [s6.1] Calcolo ricorsivo del fattoriale
*nome del file sorgente fattoriale.asm*

Si scriva un programma che, dato un intero positivo *n*, stampi a video il fattoriale di *n*.
- *F(n) = n\*F(n-1)*, se *n > 0*;
- *F(n) = 1*, se *n=0*;

## [s6.2] Calcolo ricorsivo della serie di Fibonacci
*nome del file sorgente fibonacci.asm*

Si scriva un programma che, dato un intero positivo *n*, stampi a video il fattoriale di *n* e l’*n*-esimo numero di Fibonacci *F(n)* dove *F(n)=*

- *F(n) = F(n-2)* + *F(n-1)*, se *n > 1*;
- *F(n) =1*, se *n=1*;
- *F(n) =0*, se *n=0*.

## [s6.3] Somma ricorsiva degli elementi in un array
*nome del file sorgente somma_ricorsiva.asm*

Si implementi una procedura ricorsiva `S` che prenda in input un array e il numero di elementi di quell’array e restituisca la somma di tutti gli elementi dell’array. 
Si usi come riferimento il seguente codice sorgente C:

```c
int S(int arr[], int dim){
	if (dim==0) // caso base: array vuoto
		return 0;
	else // step ricorsivo
		return S(arr, dim-1) + arr[dim-1];
}
```