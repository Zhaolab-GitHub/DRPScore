# DRPScore: Evaluating native-like structures of RNA-protein complexes through the deep learning method

## Requirements
This repo was tested with Ubuntu 18.04.5 LTS, Python 3.7, PyTorch 1.8.0, tensorboardX, biopython and CUDA 11.0. You will need at least 48GB VRAM (e.g. Nvidia RTX-A6000) for running full experiments in this repo.

attention:The input objects of 4DCNN are amino acids and residues at the interaction interface of RNA-protein within 6A, which can be obtained through ./6A_calculation. 

## Using a decoy (PDB ID:3EGZ) as an example, we show the use of three modules.

## 1: get amino acids and residues at the interaction interface of RNA-protein within 6A.
### This step is not necessary if you can directly provide amino acids and residues at the protein-RNA interaction interface within 6A
cd ./6A_calculation   
python rpo.py in out

The commands above will calculate the amino acids and residues at the protein-RNA interaction interface within 6A provided in ./6A_calculation/in and generate the results in ./6A_calculation/out.

### attention: For structures containing multiple chains, you need to manually delete protein-protein, RNA-RNA self-interactions from the output file.

cat complex1.pdb_*.txt > complex1.pdb_6A.txt  
grep -wf complex1.pdb_6A.txt complex1.pdb > Acomplex1.pdb

The commands above will generate a pdb file containing only amino acids and residues at the interaction interface within 6A.
## 2: Generate the scoring preparation file '*.npy'.

cd ./4DCNN/data/predict/  
python Main.py -pl pdblist  (to assess an RNA-protein complex)  
python Main.py -pn pdbname  (to assess a list of RNA-protein complexes)

The commands above will generate a preparation file '*.npy' of RNA-protein complexes in pdblist for DRPScore.

## 3.Prediction by 4DCNN.
cd ./4DCNN  
python pred.py

The above commands will predict all *.npy files provided in /data/predict/, scoring results are output in the scoring.txt.
The first column is the name of the RNA-protein complex evaluated, and the third column is the probability that it is a native structure.

For the case where both RNA and protein are single-stranded, we provide a simple chain(6A_calculation.sh and DRPScore.sh) to use the flow from pdb files to scoring.

## Contacts
For any questions, please contact authors.

## Acknowledgment
Thanks the author for the original [Conv4d](https://github.com/ZhengyuLiang24/Conv4d-PyTorch) implementation.
Thanks the author for the original [RNA3DCNN](https://github.com/lijunRNA/RNA3DCNN) implementation.
