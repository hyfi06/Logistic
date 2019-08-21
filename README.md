# Logistic

## SYNOPSIS

    logistic.sh [OPTIONS] [-o FILE] [NUM]

## DESCRIPTION

Crea el diagrama de birfurcación de la ecuación logarítmica, x_0 = 0.001, x_{n+1} = r * x_n (1 - x_n), del intervalo  r=1.1 a r=4. Para ello se divide el intervalo en [NUM] partes.

## OPTIONS

| Opciones | Descripción |
|-|-|
|-p, -parallel | Ejecución en paralelo usando parallel.|
|-k, --killfiles | Elimina los archivos generados durante el proceso, sobreviven las salidas únicamente.|
|-v, --verbose |  Muestra las salidas a pantalla.
|-h, --help | Muestra esta ayuda y finaliza.|
|-s, --show | Muestra la gráfica en gnuplot al finalizar.|

## PARAMETER

| Paramentro | Descripción |
|-|-|
|NUM | Número de partes en las que se dividirá el intervalo (1.1,4). Si omite se generan 100 divisiones del intervalo.
|-o, --output NOMBRE | Renombra la salida como NOMBRE.ps, si se omite se genera diagrama_difuración.ps.|

## REQUERIMIENTOS MÍNIMOS

    logisticKernel.sh, logistic.gp, gnuplot

by Hector Olvera Vital
hector.olvera@ciencias.unam.mx

Este programa usa **parallel** (O. Tange (2011): GNU Parallel - The Command-Line Power Tool, ;login: The USENIX Magazine, February 2011:42-47).