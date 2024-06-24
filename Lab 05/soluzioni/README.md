# [Sessione 5] Procedure annidate

## [s5.1] Prodotto con somme

*nome del file sorgente: prodottoConSomme.asm*

Si implementino le seguenti procedure.

Procedura `somma`:

- Input: due interi `a` e `b`

- output: la somma `a+b`

Procedura `prodotto_s`

- input: due interi `a` e `b`
- output: il prodotto `a*b`

la procedura `prodotto_s` **non** utilizzi istruzioni di moltiplicazione (`mult` et simila), ma calcoli il prodotto effettuando chiamate multiple alla procedura `somma`

### Esempio 

Il prodotto 3x2 è svolto come 3+3 oppure 2+2+2

## [s5.2] Compact list

*nome del file sorgente: compactList.asm*

Si supponga di avere nel segmento dati:

- Un array `list` che possa contenere un numero massimo di 128 elementi
- Una variabile `HEAD` che indica la prima posizione libera in testa alla lista

Si implementino le seguenti procedure:

- `insert`: inserisce un elemento in testa alla lista
- `delete`: cancella un elemento arbitrario della lista e ricompatta l’array

## [s5.3] Converti in maiuscolo

Scrivere una procedura `converti` che converta in maiuscolo una stringa in input. Si faccia uso di una seconda procedura `converti_singolo_carattere` che converta solo una lettera minuscola alla volta. 

Non si fanno assunzione sul quali caratteri possa contenere la stringa in input.

Suggerimento: usare SB e LB (StoreByte e LoadByte) per gestire dati non allineati.
