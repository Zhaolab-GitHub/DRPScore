#! /bin/bash


#1: get amino acids and residues at the interaction interface of RNA-protein within 6A
for ((j=1; j<=10; j ++))
do
	cp ./complex$j.pdb ./6A_calculation/input/
	cp ./complex$j.pdb ./6A_calculation/output/
done

cd 6A_calculation
python rpo.py input output
#For structures containing multiple chains, you need to manually delete protein-protein, RNA-RNA self-interactions from the output file.

cd output
for ((j=1; j<=10; j ++))
do
	cat complex$j.pdb_*.txt > complex$j.pdb_6A.txt
	grep -wf complex$j.pdb_6A.txt complex$j.pdb > Acomplex$j.pdb
	cp ./Acomplex$j.pdb ../../npy_preparation/
done

#2: Generate the scoring preparation file '*.npy'
cd ../../npy_preparation
ls -1 | grep ".pdb$" > pdblist
python Main.py -pl pdblist
for ((j=1; j<=10; j ++))
do
	mv ./Acomplex$j.pdb.npy ../4DCNN/data/predict/
done

#3.Prediction by 4DCNN
cd ../4DCNN
python pred.py



