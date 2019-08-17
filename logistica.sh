#!/bin/bash
#####################################################
#   logistica.sh                                    #
#   by Hector Olvera Vital                          #
#   hector.olvera@ciencias.unam.mx                  #
################Resumen##############################
# Se genera el diagrama de bifurcación de la        #
# ecuanción logística de r=1.1 a r=4 con dividiendo #
# dicho intevalo en n partes. Inserta n.            #
#####################################################

expRegNum='^[0-9]+$'
paralelo=0
killFiles=0
outs=0
verbose=0

comprueba=$( which gnuplot )

if [[ -z $comprueba ]]
then
	>&2 echo -e '\033[1;31m Error\033[0m: No está instalado gnuplot. Prueba con apt install gnuplot.'
	exit 2
fi

while [[ $# -ne 0 ]]
do
	ArG=$1
	#echo $#
	case $ArG in
		-p|--parallel)
			comprueba=$( which parallel )
			if [[ -z $comprueba ]]
			then
				>&2 echo -e '\033[1;31m Error\033[0m: No está instalado parallel. Prueba con apt install parallel.'
				exit
			else
				paralelo=1
			fi
		;;
		-v|--verbose)
				verbose=1
		;;

		-k|--killfiles)
			killFiles=1
		;;

		-o|--output)
			if [[ $# -gt 2 ]]
			then
				outs=1
				nameOut=$2
			else
				>&2 echo -e '\033[1;31m Error\033[0m: Error de sitaxis, después de -o|--output se requiero un argumento'
				exit 2
			fi
			shift
		;;

		-h|--help)
				cat .logisticHelp_
				exit
		;;

		*)
			otros[${#otros[*]}]=$1
	esac

	shift
done


for i in ${otros[*]}
do
	if [[ $i =~ $expRegNum ]]
	then
		num=$i
		break
	fi
done


if [[ ${#num[*]} -eq 0 ]]
then
	>&2 echo -e '\033[1;33m Warning\033[0m: No se introdujo un número natural. El programa continuará con 100 divisiones. Pulsa Ctrl+C para detener.'
	num=100
fi

echo -n > logis_temp.data

inc=$( echo "(4-2.9) / $num" | bc -l )

if [[ $paralelo -eq 1 ]]
then
	if [ $verbose -eq 1 ]
	then
		seq 1.1 0.018 2.89 | parallel ./logistic_ -v {}
		seq 2.9 $inc 4 | parallel ./logistic_ -v {}
	else
		seq 1.1 0.018 2.89 | parallel ./logistic_ {}
		seq 2.9 $inc 4 | parallel ./logistic_ {}
	fi
else
	x=$( seq 1.1 0.018 2.89 )
	for i in $x
	do
		if [ $verbose -eq 1 ]
		then
			./logistic_ -v $i
		else
			./logistic_ $i
		fi
	done

	x=$( seq 2.9 $inc 4 )
	for i in $x
	do
		if [ $verbose -eq 1 ]
		then
			./logistic_ -v $i
		else
			./logistic_ $i
		fi
	done 
fi

if [ $verbose -eq 1 ]
then
	echo 'Ordenando los registros'
fi
sort -n -k1 logis_temp.data | uniq > logis.data
#sort -n -k1 logis_temp.data > logis.data

if [ $verbose -eq 1 ]
then
	echo 'Ejecutando gnuplot'
fi

cat logisticGNUPlot_ | gnuplot

if [ $outs -eq 1 ]
then
	mv diagrama_difuración.ps "$nameOut".ps
	echo Se creó la salida "$nameOut".ps.
else
	echo Se creó la salida diagrama_difuración.ps.
fi

if [ $killFiles -eq 1 ]
then
	rm logis.data
	rm logis_temp.data
else
	echo 'Para ver la gráfica detallada ejecuta gnuplot> plot "logis.data" u 1:2'	
fi